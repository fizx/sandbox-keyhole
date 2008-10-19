require "digest/md5"
require "fileutils"
require "uri"
module Keyhole
  class LocalDriver < Driver
    include FileUtils
    BUFFER_SIZE = 2 ** 16
    FILE_NAME_LIMIT = 2 ** 8 - 1
    
    def initialize(options = {})
      @root = options[:root] or raise "no filesystem root provided"
      @keystore = SQLiteKeystore.new(options[:keystore] || File.join(@root, "keyhole.db"))
      @base = options[:base]
    end
    
    def get(key)
      if io = io(key)
        Resource.new(io, uri(key))
      end
    end
    
    def keys(after = "", limit = "")
    end
    
    def put(key, io)
      path = key_to_path(key)
      mkdir_p(File.dirname(path))
      File.open(path, "w") do |file|
        while buffer = io.read(BUFFER_SIZE)
          file.syswrite(buffer)
        end
      end
    end
    
    def io(key)
      if exists?(key)
        File.open(key_to_path(key))
      end
    end
    
    def exists?(key)
      File.exists?(key_to_path(key))
    end
    
    def uri(key)
      if exists?(key) 
        key_to_uri(key)
      end
    end
    
  protected
  
    def key_to_path(key)
      File.join(@root, key_to_relative_path(key))
    end
    
    def key_to_uri(key)
      @base && URI.join(@base, key_to_relative_path(key))
    end
  
    def key_to_relative_path(key)
      path = File.join(Digest::MD5.hexdigest(key).scan(/.{3}/).first(3))
      path + to_filename(key)
    end
    
    def to_filename(file)
      name = file.gsub(/^[\w\.\-]+/, '_')
      if name.length > FILE_NAME_LIMIT
        name[-FILE_NAME_LIMIT..-1]
      else
        name
      end
    end
  end
end