module BBScan
  class Friend
    attr_reader :message_id, :name, :profile_url

    def initialize(message, name, profile_url)
      @message_id = message.message_id
      @name = name
      @profile_url = profile_url
    end
  end
end
