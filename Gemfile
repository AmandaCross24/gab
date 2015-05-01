source 'http://rubygems.org'

gem 'sinatra'

gem 'activerecord'
# the actual ActiveRecord library

gem 'sinatra-activerecord'
# the adapter between Sinatra and the ActiveRecord library



gem 'rake'
# a command line task runner

gem 'rack-flash3'
# flash messaging

group :development do
	gem 'sqlite3'
	# the database adapter to use the sqlite3 db system with ActiveRecord
end

group :production do
	gem 'pg'
	#Heroku prefers PostgreSQL
end