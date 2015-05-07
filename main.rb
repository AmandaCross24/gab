require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup' #loads gemfile defined ver of rack-flash
require 'rack-flash'
require './models'


# set the db name (will be created if the db does not already exist)
set :database, "sqlite3:gab.sqlite3"

# Current user sesssion
enable :sessions
set :sessions, true
use Rack::Flash, sweep: true


# def current_user
# 	if session[:user_id]
# 		User.find(session[:user_id]) : nil
# 	end
# end

# Ternary Operator
def current_user
	session[:user_id] ? User.find(session[:user_id]) : nil
end

get '/' do
	erb :home
end

post '/login' do
	my_user = User.find_by email: params[:email]
	if my_user and my_user.password == params[:password]
		session[:user_id] = my_user.id
		redirect to ('/user')
	else
		redirect to ('/signup')
	end
end

#Attempt to loop login 3 times before redirecting to signup page
# post '/login' do
# 	i = 0
# 	while i < 3
# 		my_user = User.find_by email: params[:email]
# 		if my_user and my_user.password == params[:password]
# 			session[:user_id] = my_user.id
# 			redirect to ('/user')
# 		else
# 			
# 		end
# 	end
#		redirect to ('/signup')
# end

get '/user' do
	erb :user
end

get '/signup' do
	erb :signup
end

post '/signup' do
	User.create(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password])
	# session[:user_id] = new_user.id
	flash[:notice] = "New account created"
	redirect to ('/user')
end

post '/logout' do
	session[:user_id] = nil
	"You have been logged out"
end

# <% @users.each do |user| %>   Name: <%= user.fname %> <% end %>




