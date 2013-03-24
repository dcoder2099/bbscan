require 'contextio'

module BBScan
  class Scanner
    attr_reader :account, :messages

    NEW_FRIEND_SUBJ = "New Friends On BitBiddy.com!"
    NEW_FRIEND_FROM = "no-reply@bitbuddy.com"

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
              x << z.content if z.content =~ /New Friends On BitB[iu]ddy\.com\!/ # NOTE THE TYPO IN THE MESSAGE!
            else
              $stderr.puts "Non-HTML message, message_id: #{y.message_id}"
            end
          end
        end
      end
    end

  end
end
