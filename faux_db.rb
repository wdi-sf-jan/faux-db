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
#
# POST /users - create a user based on params from form
#
# GET /users/:id - show a user's info by their id, this should display the info in a form
#
# PUT /users/:id - update a user's info based on the form from GET /users/:id
#
# DELETE /users/:id - delete a user by their id
