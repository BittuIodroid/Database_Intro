
import 'package:database_intro/database_models/user.dart';
import 'package:database_intro/utils/database_helper.dart';
import 'package:flutter/material.dart';
//import 'package:sqflite/sqflite.dart';

List _users;

void main() async{
  var db = new DatabaseHelper();



  //Add user
  int savedUser = await db.saveUser(new User("virat","kohli"));
  print("Saved User : $savedUser");





  //Get all users
  _users = await db.getAllUsers();

  for(int i=0;i<_users.length;i++) {
    User user = User.map(_users[i]);
    print("UserId : ${user.id} Username : ${user.userName}, Password : ${user.password} ");
   // print("UserName : ${_users[i]["userName"]}");
  }

    //  Get Count
  int count = await db.getCount();
  print("Count : $count");


//Retrieving a user
  User bittu = await db.getUser(1);
  print("Got One User : ${bittu.userName}");


/*
//Deleting a user
  int deletedUser = await db.deleteUser(6);
  print(deletedUser);
  print("User Deleted : ${bittu.userName}");

*/

//Updating a user
  User mishraUpdated = User.fromMap(
      {
        "id" : 5 ,                      //id to be updated
       "userName" : "updatedMishra",
       "password" : "updatedPassword",

      }
  );
  await db.updateUser(mishraUpdated);


  runApp(MaterialApp(
    title: "Database Intro",
    home: Home(),
  ));
}



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
        itemCount: _users.length,
          itemBuilder:(_, int position){        // '_' is used instead of 'BuildContext context'
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              color: Colors.white,
              elevation: 20.0,
              child: ListTile(

                leading: CircleAvatar(
                  backgroundColor:Colors.greenAccent,
                  child: Text("${User.fromMap(_users[position]).id}"),
                ),

                title: Text("User : ${User.fromMap(_users[position]).userName}"),
                subtitle: Text("Password : ${User.fromMap(_users[position]).password}"),
                onTap:() => debugPrint("${User.fromMap(_users[position]).password}"),
              ),
            );
          }),
    );
  }
}
