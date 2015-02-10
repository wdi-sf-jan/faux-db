# Faux Users DB

Your job is to implement a faux database of users, by utilizing an array
for storing all the users. You also need to think about how to increment
the id of a user by figuring out what the id of the latest user was
before the insert

## The routes you'll need:

  * `GET /` - show all users
  * `GET /users/new` - display a form for making a new user
  * `POST /users/post` - create a user based on params from form
  * `GET /users/:id` - show a user's info by their id, this should display the info in a form
  * `PUT /users/:id` - update a user's info based on the form from GET /users/:id
  * `DELETE /users/:id` - delete a user by their id

## Bonus

Implement all the requests as AJAX requests
