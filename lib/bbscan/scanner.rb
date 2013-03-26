require 'contextio'

module BBScan
  class Scanner
    attr_reader :account, :messages, :cache

    NEW_FRIEND_SUBJ = "New Friends On BitBiddy.com!" #NOTE: TYPO!!!
    NEW_FRIEND_FROM = "no-reply@bitbuddy.com"

    def initialize
      unless ENV['CIO_KEY'] and ENV['CIO_SECRET'] and ENV['BBS_MAIL']
        $stderr.puts "Environment vars CIO_KEY, CIO_SECRET, and BBS_MAIL must be set."
        return nil
      end
      @account = ContextIO.new(ENV['CIO_KEY'], ENV['CIO_SECRET']).accounts.where(email: ENV['BBS_MAIL']).first
      @cache = Cache.new
    end

    def scan
      @messages = [].tap do |msg_ary|
        account.messages.where(subject: NEW_FRIEND_SUBJ, from: NEW_FRIEND_FROM).each do |msg|
          msg_ary << Message.new(msg) unless cache.is_message_cached?(msg.message_id)
        end
      end
    end

    def messages
      @messages ||= self.scan
    end

    # Returns a 2D array of friends. Each top-level entry is a 2 element
    # array where the first element is the friend's name, and the second
    # element is the link to their profile, eg:
    # [
    #   ["Terrance Lee", "http://bitbuddy.com/users/hone02"],
    #   ["Josh Williams", "http://bitbuddy.com/users/jw"],
    #   ["Ben Hamill", "http://bitbuddy.com/users/benhamill"],
    #   ["Brad Fults", "http://bitbuddy.com/users/h3h"]
    # ]
    def friends
      @friends ||= [].tap do |buds|
        messages.each do |msg|
          msg.friends.each do |friend|
            unless cache.is_profile_cached?(friend.profile_url)
              buds << [friend.name, friend.profile_url]
              cache.add_message_to_cache(msg.message_id, friend.profile_url)
            end
          end
        end
        cache.save!
      end
    end

  end
end
