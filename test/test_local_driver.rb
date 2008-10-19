require "test/unit"
require "fileutils"
require "stringio"
require File.dirname(__FILE__) + "/../lib/keyhole"
class TestLocalDriver < Test::Unit::TestCase
  include Keyhole
  include FileUtils
  
  def setup
    @tmp = File.dirname(__FILE__) + "/tmp"
    mkdir_p @tmp
    @driver = LocalDriver.new(:root => @tmp)
    @string = "holla"
    @io = StringIO.new(@string, "r")
    @key = "foo"
  end
  
  def teardown
    rm_rf @tmp
  end
  
  def test_nonexistant_key
    assert_nil @driver.get(@key)
    assert_equal false, @driver.exists?(@key)
  end
  
  def test_put_then_io
    @driver.put(@key, @io)
    assert_equal @string, @driver.io(@key).read
  end
  
  def test_put_then_get
    @driver.put(@key, @io)
    resource = @driver.get(@key)
    assert_kind_of Resource, resource
    assert_equal @string, resource.io.read
  end
  
  def test_factory_returns_driver
    assert_kind_of Driver, @driver
  end
  
  def test_methods
    %w[get put next reset rename uri url io exists? size_of].each do |method|
      assert_respond_to @driver, method.to_sym
    end
  end
end