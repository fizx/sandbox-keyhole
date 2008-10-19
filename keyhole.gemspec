Gem::Specification.new do |s|
  s.name     = "keyhole"
  s.version  = "0.1.0"
  s.date     = "2008-04-24"
  s.summary  = "Filesystem facade"
  s.email    = "kyle@kylemaxwell.com"
  s.homepage = "http://kylemaxwell.com"
  s.description = "Don't rely on one filesystem as you scale"
  s.has_rdoc = false
  s.files    = ["lib/keyhole/driver/local_driver.rb", "lib/keyhole/driver.rb", "lib/keyhole/factory.rb", "lib/keyhole/resource.rb", "lib/keyhole.rb", "README", "test/test_keyhole.rb", "test/test_local_driver.rb"]
  s.add_dependency("sqlite3", ["> 0.0.0"])
end