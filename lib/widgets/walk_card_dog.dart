import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_app_ui/theme/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pet_app_ui/maps_launcher.dart';

class WalkGroupCard extends StatelessWidget {
  final String imgScr;
  final String title;
  final String casetype;
  final String location;
  final String members;
  final String orgBy;
  final String phoneno;
  final double lat;
  final double long;
  final String userid;
  const WalkGroupCard({
    Key key,
    this.casetype,
    this.lat,
    this.long,
    this.phoneno,
    this.imgScr,
    this.title,
    this.location,
    this.members,
    this.orgBy,
    this.userid,
  }) : super(key: key);

  void callPhone() async {
    DocumentSnapshot casedoc =
        await Firestore.instance.collection("users").document(userid).get();
    String phoneNo = casedoc['phoneno'];
    Duration duration = Duration(milliseconds: 1000);
    sleep(duration);
    if (await canLaunch('tel:' + phoneNo)) {
      await launch('tel:' + phoneNo);
    } else {
      throw 'Could not Call Phone';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: textWhite,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(3, 1))
            ]),
        child: Container(
          width: 280,
          child: Column(
            children: <Widget>[
              Container(width: 280, height: 200, child: Image.network(imgScr)),
              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Case type : $casetype",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        MapsLauncher.launchCoordinates(
                            lat, long, 'Google Headquarters are here');
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            location,
                            style: contentBlack,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        callPhone();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.phone,
                            size: 17,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            members,
                            style: contentBlack,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: <Widget>[
                    //     Icon(Icons.account_circle,size: 20,),
                    //     SizedBox(width: 15,),
                    //     RichText(text:
                    //     TextSpan(
                    //       text: "Organized by ",
                    //       style: contentBlack,
                    //       children: <TextSpan>[
                    //         TextSpan(text: orgBy,style: TextStyle(color: primary)),
                    //       ]
                    //     )
                    //     )
                    //     // Text("Organized by Laura ",style: contentBlack,)
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
