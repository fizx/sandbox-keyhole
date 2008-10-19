module Keyhole;end
Dir[File.dirname(__FILE__) + "/keyhole/*.rb"].each do |file|
  require file.sub(/\.rb$/, '')
end