require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup' #loads gemfile defined ver of rack-flash
require 'rack-flash'
require './models'


# set the db name (will be created if the db does not already exist)
set :database, "sqlite3:gab.sqlite3"

# Current user sesssion
set :sessions, true
#enable :sessions

use Rack::Flash, sweep: true

# def current_user
# 	if session[:user_id]
# 		User.find(session[:user_id])
# 	else
# 		nil
# 	end
# end

#Ternary Operator
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

get '/user' do
	erb :user
end

get '/signup' do
	erb :signup
end

post '/signup' do
#	if user is logged in, redirect to user page
	if 	session[:current_user_id] != nil
		redirect to ('/user')
	else
#	else create new user
		new_user = User.create(fname: params[:fname], lname: params[:lname], email: params[:email], password: params[:password])
		session[:user_id] = new_user.id
		flash[:notice] = "New account created"
		redirect to ('/user')
	end
end

get '/logout' do
	session[:user_id] = nil
	flash[:notice] = "You have logged out"
	redirect to ('/')
end

# get '/loggedin' do
# 	"You are logged in #{current_user.fname if current_user}!"
# end

# Attempt to loop login 3 times before redirecting to signup page
# post '/login' do
# 	i = 0
# 	while i < 3
# 		my_user = User.find_by email: params[:email]
# 		if my_user and my_user.password == params[:password]
# 			session[:user_id] = my_user.id
# 			redirect to ('/user')
# 		else
# 			i++                                                                                                                                                                                          
# 		redirect to ('/signup')
# 	end
# end

# post '/login' do
# 	i = 0
# 	while i < 3
# 		my_user = User.find_by email: params[:email]
# 		if my_user and my_user.password != params[:password]
# 			i++      
# 			redirect to ('/')
# 		else
# 			session[:user_id] = my_user.id
#             redirect to ('/user')
# 		end
# 	otherwise do
# 		redirect to ('/signup')
# 	end
# end

