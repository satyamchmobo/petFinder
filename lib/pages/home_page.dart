import 'package:flutter/material.dart';
import 'package:pet_app_ui/controller/userDataController.dart';
import 'package:pet_app_ui/pages/add_products.dart';
import 'package:pet_app_ui/theme/constant.dart';
import 'package:pet_app_ui/widgets/dog_card.dart';
import 'package:pet_app_ui/widgets/walk_card_dog.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  String userid;
  Homepage({this.userid});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<UserDataController>(builder:
        (context, UserDataController userDataController, Widget child) {
      print(userDataController.uid.toString());
      //var username=userDataController.nam
      var username = userDataController.uname;
      var ud = userDataController.uid.toString();

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
                        "Hi, Amol",
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      WalkGroupCard(
                        imgScr: "assets/images/dog2.jpg",
                        title: "Case : Injury",
                        location: "Tap to Get Location",
                        members: "Contact to uploader",
                        orgBy: "",
                      ),
                      WalkGroupCard(
                        imgScr: "assets/images/card_dog_2.png",
                        title: "Case : Adoption",
                        location: "Tap to Get Location",
                        members: "8 memmbers",
                        orgBy: "Laura",
                      ),
                      // WalkGroupCard()
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ));
    });
  }
}
