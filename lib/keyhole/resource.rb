require "uri"
class Keyhole::Resource
  attr_reader :io, :url
  
  def initialize(io, url)
    @io = io
    @url = url
  end
  
  def uri
    URI.parse(url)
  end
end