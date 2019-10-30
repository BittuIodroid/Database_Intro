import 'package:database_intro/database_models/user.dart';
import 'package:database_intro/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

List _users;

void main() async{
  var db = new DatabaseHelper();


/*
  //Add user
  int savedUser = await db.saveUser(new User("Mishra","james"));
  print("Saved User : $savedUser");

*/


  //Get all users
  _users = await db.getAllUsers();
 //User user = User.map(_users);
  for(int i=0;i<_users.length;i++) {
    print("UserName : ${_users[i]['userName']}");
  }

    //  Get Count
  int count = await db.getCount();
  print("Count : $count");

// Retrieving a  user
  User misha = await db.getUser(3);
  print(misha.password);
  //print("Got username : ${misha.username}");




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
    );
  }
}
