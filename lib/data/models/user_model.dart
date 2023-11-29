class UserModel{
  late String id;
  late String name;
  late String email;
  bool? busy;


  UserModel({required this.name});

  UserModel.resister({required this.name, required this.id,required this.email,required this.busy});

  UserModel.fromJsonMap({required Map<String, dynamic> map,required String uId}){
    id = uId;
    name = map["name"];
    email = map["email"];
    busy = map["busy"];
  }

  Map<String,dynamic> toMap(){
    return {
      "uId": id,
      "name": name,
      "email": email,
    };
  }
}

class UserFcmTokenModel{
  late String uId, token;

  UserFcmTokenModel({required this.uId, required this.token});

  UserFcmTokenModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'token': token,
    };
  }
}