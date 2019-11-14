import 'dart:async';    //For async
import 'dart:io';     // For Directory
import 'package:database_intro/database_models/user.dart';
import 'package:path_provider/path_provider.dart';    //For providing the path
import 'package:sqflite/sqflite.dart';      //For Database
import 'package:sqflite/sqlite_api.dart';   //To use SQL query
import 'package:path/path.dart';    //To use join



//Singleton class => A class that has only one instance and it doesn't allow to create multiple instance
//This class is responsible for creating database and tables and do all the database operations.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal(); // database instance and "internal" is a user defined constructor

  factory DatabaseHelper() => _instance; // returning instance

  final String tableUser = "userTable";     // Table name
  final String columnId = "id";
  final String columnUserName = "userName";
  final String columnPassword = "password";

  static Database _db; // Database reference

  // ignore: missing_return
  Future<Database>get db async {
    if (_db == null || !_db.isOpen) {

      //Initialising Database
      Directory documentDirectory = await getApplicationDocumentsDirectory(); // Directory to create database
      String path = join(documentDirectory.path, "mainDb.db");

      var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
      return ourDb;

    }

    else{
      return _db;
    }

  }

  DatabaseHelper.internal(); // internal is a user defined Constructor




/*

  //Method to create database
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory(); // Directory to create database
    String path = join(documentDirectory.path, "mainDb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

*/






/*
  id | userName | password
  ------------------------
  1  | Bittu    | mishra
  2  | James    | Paulo
*/


  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columnUserName TEXT, $columnPassword TEXT)"
    );
  }


  //CRUD(Create, Read, Update, Delete) operation

  //Insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int response = await dbClient.insert("$tableUser", user.toMap()); // Inserting values from method "toMap" created in "user.dart"
    return response;
  }

  //Get All Users
  Future<List> getAllUsers() async {
    var dbClient = await db; //Selecting Database named "db"
    var result = await dbClient.rawQuery("SELECT * FROM $tableUser");

    return result.toList(); // Converting result to List because "rawQuery" returns List
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $tableUser"));
  }

  Future<User> getUser(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableUser WHERE $columnId = $id");
//    print("Result = $result");
    if (result.length == 0) {
      return null;

    }
    else{
      return User.fromMap(result.first);
    }
     // else
  }

  // Delete User
  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    var userDeleted = await dbClient.delete(
        tableUser, where: "$columnId = ?", whereArgs: [id]);

    if(userDeleted==0) return null;
    else return userDeleted;
  }

  // Update User
  Future<int> updateUser(User user) async {
    var dbClient = await db;
    return await dbClient.update(
        tableUser, user.toMap(), where: "$columnId = ?", whereArgs: [user.id]);
  }

  // Closing the Database
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}
