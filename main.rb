require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup' #loads gemfile defined ver of rack-flash
require 'rack-flash'
require './models'


# set the db name (will be created if the db does not already exist)
set :database, "sqlite3:microblog.sqlite3"

# Current user sesssion
# enable :sessions
set :sessions, true
Use Rack::Flash, sweep: true


def current_user
	if session[:user_id]
		User.find(session[:user_id])
	else
		nil
	end
end

# Ternary Operator
# def current_user
# 	session[:user_id] ? User.find(session[:user_id]) : nil
#  end

get '/' do
	erb :home
end

post '/login' do
	my_user = User.find_by fname: params[:fname]
	if my_user and my_user.password == params[:password]
		session[:user_id] = my_user.id
	else
		redirect("/signup")
	end
end

post '/signup' do
	User.create(params[:user])
	session[:user_id] = new_user.id
	flash[:notice] = "New account created"
end

get '/user' do
	erb :user
end

get 'logout' do
	session[:user_id] = nil
	"You have been logged out"
end

