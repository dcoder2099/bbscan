require 'yaml'

module BBScan
  class Cache
    attr_reader :store

    CACHE_FILE = ".bbscan_cache"

    def initialize
      @store = YAML::load(File.open(filename, File::CREAT|File::RDWR))
      @store = {message_cache: [], profile_cache: []} unless @store
    end

    def is_message_cached?(message_id)
      message_cache.include?(message_id)
    end

    def is_profile_cached?(profile_url)
      profile_cache.include?(profile_url)
    end

    def add_message_to_cache(message_id, profile_url)
      message_cache << message_id unless is_message_cached?(message_id)
      profile_cache << profile_url unless is_profile_cached?(profile_url)
    end

    def save!
      File.open(filename, 'w+') do |f|
        f.write @store.to_yaml
      end
    end

    def filename
      File.join(Dir.home, CACHE_FILE)
    end

    def message_cache
      store[:message_cache]
    end

    def profile_cache
      store[:profile_cache]
    end
  end
end
