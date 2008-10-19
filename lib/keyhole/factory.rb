class Keyhole::Factory
  attr_accessor :options
  
  def initialize(driver = Keyhole::Driver::DEFAULT, options = {})
    @driver = driver
    @options = options
  end
  
  def instance
    @driver.new(options)
  end
end