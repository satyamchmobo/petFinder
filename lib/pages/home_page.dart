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
                    Text(
                      "Hi, Ferran",
                      style: appTitle,
                    ),
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
                      "Check out the new products, groups, events, places and more!",
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
                      "Walk groups".toUpperCase(),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text("See All")
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
                        imgScr: "assets/images/card_dog_1.png",
                        title: "Meet our lovely dogs walking with us",
                        location: "Valencia, Spain",
                        members: "8 memmbers",
                        orgBy: "Laura",
                      ),
                      WalkGroupCard(
                        imgScr: "assets/images/card_dog_2.png",
                        title: "Meet our lovely dogs walking with us",
                        location: "Valencia, Spain",
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
