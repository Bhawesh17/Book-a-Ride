import 'dart:ffi';

import 'package:book_a_ride/feature/vehicle_detail_scree/vehicle_detials.dart';
import 'package:book_a_ride/module/fetch_module.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var height, width;
  List<dynamic> liveData = [];
  List<String> imgData = [];
  var data = FirebaseDatabase.instance.ref("Table");

  work(img1, img2, img3, img4) {
    imgData.add(img1);
    imgData.add(img2);
    imgData.add(img3);
    imgData.add(img4);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Icon(
          Icons.sort,
          color: Colors.white,
          size: 40,
        ),
      ),
      body: SafeArea(
          child: Container(
        height: height,
        width: width,
        color: Colors.indigo,
        child: Column(
          children: [
            Container(
              height: height * 0.15,
              width: width,
              decoration: BoxDecoration(),
              child: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                    child: Text(
                  'Book A Ride',
                  style: TextStyle(
                      fontFamily: "Shizuru",
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
              ),
            ),
            Container(
              height: height * 0.70,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Container(
                  margin: EdgeInsets.only(top: 40),
                  // child: FirebaseAnimatedList(query: data,
                  //     itemBuilder: (context, snapshot, animation,index){
                  //       return ListTile(
                  //        // leading: Image.network(snapshot.child("Images").value.toString()),
                  //         title: Text(snapshot.child('Name').value.toString()),
                  //
                  //       );
                  //
                  //     }
                  // ),
                  child: StreamBuilder(
                      stream: data.onValue,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value as dynamic;

                          liveData.clear();
                          liveData = map.values.toList();
                        }

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            mainAxisSpacing: 25,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: liveData.length,
                          itemBuilder: (BuildContext context, int index) {
                            String imageShow = liveData[index]["Images"];
                            return InkWell(
                              onTap: () async {
                                await work(
                                    liveData[index]["Images"],
                                    liveData[index]["Images1"],
                                    liveData[index]["Images2"],
                                    liveData[index]["Images3"]);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VehicleDetialeScreen(
                                              name: liveData[index]["Name"],
                                              avability: liveData[index]
                                                  ["Ready"],
                                              imgList: imgData,
                                              contact: liveData[index]["Cont"],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 6,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Image.network(imageShow),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Driver Name : "),
                                        Text(liveData[index]["Name"]),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Avability : "),
                                        Text(liveData[index]["Ready"]),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 10,
                                      width: width,
                                      decoration: BoxDecoration(
                                        //   color: liveData[index]["Ready"]  ? Colors.green : Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          // ),
                        );
                      })),
            ),
          ],
        ),
      )),
    );
  }
}
