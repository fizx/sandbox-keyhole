require "test/unit"
require File.dirname(__FILE__) + "/../lib/keyhole"
class TestKeyhole < Test::Unit::TestCase
  include Keyhole
  
  def setup
    @driver = Factory.new.instance
  end
  
  def teardown
  end
  
  def test_factory_returns_driver
    assert_kind_of Driver, @driver
  end
  
  def test_methods
    %w[get put keys rename uri url io exists? size_of].each do |method|
      assert_respond_to @driver, method.to_sym
    end
  end
end