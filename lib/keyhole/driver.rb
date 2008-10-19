# Abstract class defines the interface drivers should implement
module Keyhole
  class Driver
    DEFAULT = self
  
    def initialize(options = {})
    end
  
    # Returns a Keyhole::Resource, or nil
    def get(key)
      raise "not implemented"
    end
  
    # Puts the contents of the io into the distributed hash table/filesystem
    def put(key, io)
      raise "not implemented"
    end
    
    # Lists keys lexicographically greater than the listed key.  Useful for
    # paging through all keys
    def keys(after = "", limit = 1000)
      raise "not implemented"
    end
    
    # Deletes the key
    def delete(key)
      raise "not implemented"
    end
   
    # Renames a resource
    def rename(from, to)
      raise "not implemented"
    end
  
    # Gets a URI object of the resource at the key
    def uri(key)
      get(key).uri
    end
  
    # Gets a url as a String of the resource at the key
    def url(key)
      get(key).url
    end
  
    # Gets an IO object of the resource at the key
    def io(key)
      get(key).io
    end
  
    # Is there a resource at the key?
    def exists?(key)
      !get(key).nil?
    end
  
    # Size in bytes of the resource at the key.
    def size_of(key)
      raise "not implemented"
    end
  end
end

Dir[File.dirname(__FILE__) + "/driver/*.rb"].each do |file|
  require file.sub(/\.rb$/, '')
end