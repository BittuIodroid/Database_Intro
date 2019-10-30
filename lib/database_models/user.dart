
class User{
  int _id;
  String _userName;
  String _password;

  User(this._userName,this._password);  // Constructor

  User.map(dynamic obj){
    this._id = obj['id'];
    this._userName = obj['username'];
    this._password = obj['password'];
  }

  int get id => _id;
  String get username => _userName;
  String get password => _password;

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();    // key : value(String = key,dynamic = value)
    map["username"] = _userName;
    map["password"] = _password;

    if(id!=null){
      map["id"] = _id;
    }
    return map;

  }

  User.fromMap(Map<String, dynamic> map){
    this._id = map["id"];
    this._userName = map["username"];
    this._password = map["password"];
  }

}