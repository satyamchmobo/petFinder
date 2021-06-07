import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String uname;
  String uid;
  String lat;
  String long;
  String phoneno;

  UserData({this.uid, this.uname, this.lat, this.long, this.phoneno});
  @override
  String toString() {
    return 'UserData : { username: ' +
        uname +
        ' , uid: ' +
        uid +
        ' , lat: + ' +
        lat +
        ' , long: ' +
        long +
        'phoneno: ' +
        phoneno +
        ' }';
  }
}
