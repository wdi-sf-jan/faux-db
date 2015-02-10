require 'pry'
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

users = []
id = 1

get '/' do
  erb :index
end

get '/index.json' do
  @users = users
  json @users
end

post '/create.json' do
  user = {}
  user[:id] = id
  user[:name] = params[:user]
  id += 1
  users << user
  json user
end

put '/update/:id.json' do
  users.each do |user|
    if(params[:id].to_i == user[:id])
      user[:name] = params[:user]
      @user = user
    end
  end
  json nil
end

delete '/delete/:id.json' do
  users.each_with_index do |user, index|
    if(params[:id].to_i == user[:id])
      users.delete_at(index)
    end
  end
  json nil
end
