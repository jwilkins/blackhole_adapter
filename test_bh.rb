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
# => 0

user = User.new
user.first_name = "Rumplestiltskin"
user.save

puts User.count
# => 0
