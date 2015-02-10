$(document).ready(function(){
  var li, button, id;
  // define a function to show all the users
  function getUsers(){
    $.getJSON("/users.json", function(data){
      data.forEach(function(user){
        li = $("<li data-id=" + user.id+"><span class='name show'>" + user.name + " </span></li>");
        button = $(" <button class='delete'></button>").text("Delete");
        li.append(button);
        $("ul").append(li);
      });
    });
  }
  //call the function to get the list of users
  getUsers();

  // when the add new user form is submitted, fire an ajax call to add a new one
  $(".addUser").on("submit", function(e){
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: "/users.json",
      data: {user: $("#user").val()},
      success: function(user){
        li = $("<li data-id=" + user.id+"><span class='name show'>" + user.name + "</span></li>");
        button = $("<button class='delete'></button>").text("Delete");
        li.append(button);
        $("ul").append(li);
        },
        error: function(err){
          alert("You fucked up!");
        }
    });
    $("#user").val("");
  });

  // When a name is double clicked, show the input and hide the delete button
  // Added the additional class of show so that you can only double click once
  $("body").on("dblclick", "li .show", function(){
    input = $("<input type='text' class='newName' value="+ $(this).text() +">");
    button = $("<button class='update'></button>").text("Update");
    $(this).text("");
    $(this).removeClass("show");
    $(this).append(input);
    $(this).next().hide();
    $(this).append(button);
  });

  // When the update button is clicked, make an AJAX call to update the name
  $("body").on("click", ".update", function(){
    _this = $(this);
    id = $(this).parent().parent().data("id");
    $.ajax({
      type: "PUT",
      data: {user: $(".newName").val()},
      url: "/users/" + id +".json",
      success: function(data){
        _this.parent().text($(".newName").val());
        $(".name").addClass("show");
        $(".delete").show();
        console.log("Updated!");
      },
      error: function(err){
        console.log("Oops, something went wrong!", err);
      }
    });
  });

  // When the delete button is clicked, remove the li and make an AJAX call to delete
  $("body").on("click",".delete",function(e){
    _this = $(this);
    id = $(this).parent().data("id");
    $.ajax({
      type: "DELETE",
      url: "/users/" + id +".json",
      success: function(data){
        _this.parent().remove();
        console.log("Deleted!");
      },
      error: function(err){
        console.log("Oops, something went wrong!", err);
      }
    });
  });
});