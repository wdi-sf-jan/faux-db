require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

users = []
id = 1

get '/' do
  @users = users
  erb :index
end

get '/add' do
  erb :add
end

post '/add' do
  user = {}
  user[:id] = id
  user[:name] = params[:user]
  id += 1
  users << user
  redirect '/'
end

get '/edit/:id' do
  users.each do |user|
    if(params[:id].to_i == user[:id])
      @user = user
    end
  end
  erb :edit
end

put '/edit/:id' do
  users.each do |user|
    if(params[:id].to_i == user[:id])
      user[:name] = params[:user]
      @user = user
    end
  end
  redirect '/'
end

delete '/delete/:id' do
  users.each_with_index do |user, index|
    if(params[:id].to_i == user[:id])
      users.delete_at(index)
    end
  end
  redirect '/'
end
