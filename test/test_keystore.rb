require "test/unit"
require "fileutils"
require File.dirname(__FILE__) + "/../lib/keyhole/sqlite_keystore"
class TestKeystore < Test::Unit::TestCase
  include Keyhole
  include FileUtils
  
  def setup
    @file = "tmp.db"
    @store = SQLiteKeystore.new @file
  end
  
  def teardown
    rm @file
  end
  
  def test_put
    @store.put "hello"
    assert @store.exists?("hello")
    assert_equal ["hello"], @store.keys
  end

  def test_keys
    keys = %w[a b c aa bb cc]
    keys.each {|k| @store.put k }
    assert_equal keys.sort, @store.keys
    
    assert_equal 4, @store.keys("aaa").length
  end
  
  def test_exists
    @store.put "hello"
    assert @store.exists?("hello")
    assert !@store.exists?("other")
  end
  
end