require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# this will store your users
users = []

# routes to implement:
#
# GET / - show all users
get '/' do
  @users = users
  erb :index
end

# GET /users/new - display a form for making a new user
get '/users/new' do
  erb :new
end

# POST /users - create a user based on params from form
post '/users' do
  user = {}
  user[:id] = id
  user[:name] = params[:user]
  id += 1
  users << user
  redirect '/'
end

# GET /users/:id - show a user's info by their id, this should display the info in a form
get '/users/:id' do
  users.each do |user|
    if(params[:id].to_i == user[:id])
      @user = user
    end
  end
  erb :edit
end

# PUT /users/:id - update a user's info based on the form from GET /users/:id
put '/users/:id' do
  users.each do |user|
    if(params[:id].to_i == user[:id])
      user[:name] = params[:user]
      @user = user
    end
  end
  redirect '/'
end

# DELETE /users/:id - delete a user by their id
delete '/users/:id' do
  users.each_with_index do |user, index|
    if(params[:id].to_i == user[:id])
      users.delete_at(index)
    end
  end
  redirect '/'
end
