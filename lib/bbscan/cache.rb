module BBScan
  class Cache
    def is_email_cached?(email_address)
      false
    end

    def is_message_cached?(message_id)
      false
    end

    def add_message_to_cache!(message_id, emails)
      false
    end
  end
end
