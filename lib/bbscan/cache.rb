module BBScan
  class Cache
    def is_message_cached?(message_id)
      false
    end

    def is_profile_cached?(profile_url)
      false
    end

    def add_message_to_cache(message_id, profile_url)
      false
    end

    def save!
      false
    end
  end
end
