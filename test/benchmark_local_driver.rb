#!/usr/bin/env ruby
require File.dirname(__FILE__) + "/../lib/keyhole"
require "benchmark"
require "fileutils"

N = 100
FILE_SIZE = (2 ** 16)

def io
  @io ||= StringIO.new "a" * FILE_SIZE
  @io.rewind
  @io
end

@tmp = File.dirname(__FILE__) + "/tmp"
@driver ||= Keyhole::LocalDriver.new(:root => @tmp)
io

Benchmark.bm do |bm|
  bm.report("#{N} writes") do 
    N.times do |i|
      @driver.put(i.to_s, io)
    end
  end
  
  bm.report("#{N} io reads") do 
    N.times do |i|
      @driver.io(i.to_s).read
    end
  end
  
  bm.report("#{N} gets") do 
    N.times do |i|
      @driver.get(i.to_s).io.read
    end
  end
  
  bm.report("#{N} iterative reads") do 
    @driver.keys.each do |key|
      @driver.io(key).read
    end
  end
  
  bm.report("#{N} deletes") do 
    N.times do |i|
      @driver.delete(i.to_s)
    end
  end
end

FileUtils.rm_rf @tmp