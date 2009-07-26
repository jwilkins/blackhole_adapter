require 'rubygems'
require 'active_record'
require 'blackhole_adapter'
require 'yaml'
require 'logger'

dbconfig = YAML::load(File.open('database.yml'))
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDERR)

class User < ActiveRecord::Base
end

puts User.count
# SQL (0.000277)   SELECT count(*) AS count_all FROM users
# => 0
