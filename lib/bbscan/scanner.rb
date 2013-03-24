require 'contextio'
require 'nokogiri'

module BBScan
  class Scanner
    attr_reader :account, :messages

    NEW_FRIEND_SUBJ = "New Friends On BitBiddy.com!"
    NEW_FRIEND_FROM = "no-reply@bitbuddy.com"

    # The regexen used are mildly complicated because the message is html
    # and the content of the regex match could have linebreaks internally
    NEW_FRIENDS_REGEX = /New\s+Friends\s+On\s+BitB[iu]ddy\.com\!/ # NOTE THE TYPO IN THE MESSAGE!
    YOUR_FRIEND_REGEX = /is\s+now\s+your\s+friend/

    def initialize
      @account = ContextIO.new(ENV['CIO_KEY'], ENV['CIO_SECRET']).accounts.where(email: ENV['BBS_MAIL']).first
    end

    def scan
      @messages = [].tap do |x|
        account.messages.where(subject: NEW_FRIEND_SUBJ, from: NEW_FRIEND_FROM).each{|y| x << y}
      end
    end

    def messages
      @messages ||= self.scan
    end

    # At the moment, the only kind of messages I have to work with are
    # HTML-formatted only (no text only or dual-format). So this just
    # iterates over the messages and extracts the message body into a
    # string blob that can be processed by nokogiri.
    def content_blobs
      @content_blobs ||= [].tap do |x|
        messages.each do |y|
          y.body_parts.each do |z|
            if z.html?
              x << z.content if z.content =~ NEW_FRIENDS_REGEX
            else
              $stderr.puts "Non-HTML message, message_id: #{y.message_id}"
            end
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
            els << el if el.content =~ YOUR_FRIEND_REGEX
          end
        end
      end
    end

  end
end
