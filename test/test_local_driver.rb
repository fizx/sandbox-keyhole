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
    @key = "foo"
  end
  
  def io
    StringIO.new(@string, "r")
  end 
  
  def teardown
    rm_rf @tmp
  end
  
  def test_iteration
    keys = ("a".."z").to_a
    keys.each do |key|
      @driver.put(key, io)
    end
    assert_equal 26, @driver.keys.length
  end
  
  def test_delete
    @driver.put("foo", io)
    assert @driver.exists?("foo")
    @driver.delete("foo")
    assert !@driver.exists?("foo")
    assert_equal 0, @driver.keys.length
  end
  
  def test_nonexistant_key
    assert_nil @driver.get(@key)
    assert_equal false, @driver.exists?(@key)
  end
  
  def test_put_then_io
    @driver.put(@key, io)
    assert_equal @string, @driver.io(@key).read
  end
  
  def test_put_then_get
    @driver.put(@key, io)
    resource = @driver.get(@key)
    assert_kind_of Resource, resource
    assert_equal @string, resource.io.read
  end
  
  def test_driver
    assert_kind_of Driver, @driver
  end
end