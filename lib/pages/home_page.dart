import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pet_app_ui/controller/userDataController.dart';
import 'package:pet_app_ui/main.dart';
import 'package:pet_app_ui/pages/add_products.dart';
import 'package:pet_app_ui/theme/constant.dart';
import 'package:pet_app_ui/widgets/dog_card.dart';
import 'package:pet_app_ui/widgets/walk_card_dog.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  String userid;
  HomePage({Key key, this.userid}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double latitudevalue = 0;
  double longitudevalue = 0;
  final _formKey = GlobalKey<FormState>();
  void _getCurrentLocation() async {
    // bdoublool serviceEnabled;

    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      latitudevalue = position.latitude;
      longitudevalue = position.longitude;
    });
  }

  // String userid;
  // String username;
  // Homepage({this.userid,this.username});
  @override
  initState() {
    _getCurrentLocation();
    // _signInAnonymously();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<UserDataController>(builder:
        (context, UserDataController userDataController, Widget child) {
      print(userDataController.uid.toString());
      //var username=userDataController.nam
      var username = userDataController.uname;
      var u = widget.userid;
      print(u);
      var ud = userDataController.uid.toString();
      print(userDataController.uname.toString());

      print(" printing in root home pageHHHHHHHHHHHHHH");
      return SafeArea(
          child: ListView(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<UserDataController>(builder: (context,
                        UserDataController userDataController, Widget child) {
                      return Text(
                        "Hi," +" Amol",
                        style: appTitle,
                      );
                    }),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProducts()),
                        );
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.teal[300],
                                    border: Border.all(
                                      color: Colors.teal[700],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                            Text('Add helpless animal')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: size.width * 0.7,
                    child: Text(
                      "You can see the cases below and add the cases besides! ",
                      style: contentBlack,
                    )),
                SizedBox(
                  height: 50,
                ),
                DogCard(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Cases within -  5km".toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text("See All Cases")
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  child: StreamBuilder(
                    stream: Firestore.instance.collection("cases").snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      // return !snapshot.hasData
                      //     ? Text('PLease Wait')
                      //     :

                      final documents = snapshot.data.documents.reversed;
                      List<WalkGroupCard> messageWidgets = [];
                      List<DocumentSnapshot> listofDocSnapsToShow = [];

                      // double distanceInMeters = await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
                      for (var doc1 in documents) {
                        print((doc1.data['lat'] - latitudevalue).abs());
                        print("--==-=-=");
                        if ((doc1.data['lat'] - latitudevalue).abs() < 0.05 &&
                            (doc1.data['long'] - longitudevalue).abs() < 0.05) {
                          listofDocSnapsToShow.add(doc1);
                        }
                      }
                      for (var doc in listofDocSnapsToShow) {
                        final userid = doc.data['userid'];
                        final image = doc.data['image1'];
                        final lat = doc.data['lat'];
                        final long = doc.data['long'];
                        final caseType = doc.data['casetype'];

                        final walkWidget = WalkGroupCard(
                             imgScr: image,
                          title: "Case : Injury",
                          location: "Tap to Get Location",
                          members: "Contact to uploader",
                          orgBy: "",
                          //phoneno: "9179772425",
                          userid: userid,
                          casetype: caseType,
                          lat: lat,
                          long: long,
                        );

                        messageWidgets.add(walkWidget);
                      }

                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: messageWidgets,
                      );

                      // ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: snapshot.data.documents.length,
                      //     itemBuilder: (context, index) {
                      //       print(snapshot.data.documents.length);
                      //       print("=====>");
                      //       DocumentSnapshot whatsappbotdocsnap =
                      //           snapshot.data.documents[index];
                      //       var userid = whatsappbotdocsnap['userid'];

                      //       return WalkGroupCard(
                      //         imgScr: whatsappbotdocsnap['image1'],
                      //         title: "Case : Injury",
                      //         location: "Tap to Get Location",
                      //         members: "Contact to uploader",
                      //         orgBy: "",
                      //         phoneno: "9179772425",
                      //         userid:userid,
                      //         lat: whatsappbotdocsnap['lat'],
                      //         long: whatsappbotdocsnap['long'],
                      //       );
                      //     },
                      //   );
                    },
                  ),
                ),

                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: <Widget>[
                //       WalkGroupCard(
                //         imgScr: "assets/images/dog2.jpg",
                //         title: "Case : Injury",
                //         location: "Tap to Get Location",
                //         members: "Contact to uploader",
                //         orgBy: "",
                //       ),
                //       WalkGroupCard(
                //         imgScr: "assets/images/card_dog_2.png",
                //         title: "Case : Adoption",
                //         location: "Tap to Get Location",
                //         members: "8 memmbers",
                //         orgBy: "Laura",
                //       ),
                //       // WalkGroupCard()
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ],
      ));
    });
  }
}
