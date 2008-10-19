require "rubygems"
require "sqlite3"
module Keyhole
  class SQLiteKeystore
    def initialize(path)
      @db = SQLite3::Database.new(path)
      @db.execute <<-SQL
        CREATE TABLE IF NOT EXISTS keys (name TEXT PRIMARY KEY);
      SQL
    end
    
    def put(key)
      @db.execute(%[REPLACE INTO keys (name) VALUES (?)], key)
    end
    
    def exists?(key)
      @db.get_first_value(%[SELECT COUNT(1) FROM keys WHERE name = ?], key).to_i == 1
    end
    
    def delete(key)
      @db.execute(%[DELETE FROM keys WHERE name = ?], key)
    end
    
    def keys(after = nil, limit = 1000)
      if after
        @db.execute(%[SELECT name FROM keys WHERE name > ? ORDER BY name LIMIT #{limit}], after).flatten
      else
        @db.execute(%[SELECT name FROM keys ORDER BY name LIMIT #{limit}], after).flatten
      end
    end
  end
end