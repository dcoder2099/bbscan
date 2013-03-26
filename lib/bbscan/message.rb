require 'nokogiri'

module BBScan
  class Message
    attr_reader :message, :friends

    # The regexen used are mildly complicated because the message is html
    # and the content of the regex match could have linebreaks internally
    NEW_FRIENDS_REGEX = /New\s+Friends\s+On\s+BitB[iu]ddy\.com\!/ # NOTE THE TYPO IN THE MESSAGE!
    YOUR_FRIEND_REGEX = /is\s+now\s+your\s+friend/

    def initialize(message)
      @message = message
    end

    def message_id
      message.message_id
    end

    def friends
      @friends ||= [].tap do |buds|
        elements.each do |el|
          buds << Friend.new(self, el.content.gsub(/\s+/, ' '), el.attr('href'))
        end
      end
    end

    private

    # At the moment, the only kind of messages I have to work with are
    # HTML-formatted only (no text only or dual-format). So, this just
    # iterates over the message's body_parts array to extract the HTML
    # blob into a string that can be processed by nokogiri.
    def content_blobs
      @content_blobs ||= [].tap do |blobs|
        message.body_parts.each do |body|
          if body.html?
            blobs << body.content if body.content =~ NEW_FRIENDS_REGEX
          else
            $stderr.puts "Non-HTML message, message_id: #{message_id}"
          end
        end
      end
    end

    # Returns an array of nokogiri elements for each of our line matches.
    # A matched line is one that satisfies the css selector "table td p" and
    # contains the content "is now your friend".
    def elements
      @elements ||= [].tap do |els|
        content_blobs.each do |blob|
          Nokogiri::HTML(blob).css("table td p").each do |el|
            # grab the hyperlink out of the matched paragraph
            els << el.css('a').first if el.content =~ YOUR_FRIEND_REGEX
          end
        end
      end
    end

  end
end
