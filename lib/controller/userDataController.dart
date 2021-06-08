import 'package:flutter/material.dart';
import 'package:pet_app_ui/model/userData.dart';
import 'package:flutter/cupertino.dart';

class UserDataController extends ChangeNotifier {
  String uname = "";
  String uid="f";
  String lat = "";
  String long = "";
  String phoneno = "";

  UserDataController({this.uname, this.uid, this.lat, this.long, this.phoneno});

  void setUserData(UserData udata) {
   uname = udata.uname.toString();
    uid = udata.uid.toString();
   lat = udata.lat;
   long = udata.long;
   phoneno = udata.phoneno;
    // print(uid);
    // print("uid inside controller-=-------------");
    notifyListeners();
  }
}
