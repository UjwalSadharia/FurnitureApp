import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';
import '../models/product_model.dart';

class DetailsScreen extends StatefulWidget {
  final String? id;
  const DetailsScreen({Key? key, this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}




class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange.shade900,
        appBar: AppBar(
            backgroundColor: backroundColor,
            elevation: 0.0,
            foregroundColor: Colors.black),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("Products")
              .doc(widget.id)
              .get(),
          builder: (context, snapshot) {
            var data = snapshot.data?.data();
            if (snapshot.hasError) {
              return Text("Sorry, Something Went Wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (data != null) {
              print(data["pname"]);
            } else {
              print("No Rec");
            }
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 550,
                      decoration: BoxDecoration(
                        color: backroundColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 20,
                      child: Container(
                        height: 225,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                    Hero(
                      tag: '${data!["id"]}',
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(),
                        child: Image.asset('assets/images/${data["image"]}',
                            fit: BoxFit.cover, height: 250, width: 250),
                      ),
                    ),
                    Positioned(
                      bottom: 250,
                      left: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color.fromARGB(255, 121, 121, 121),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 99, 97, 97))),
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange.shade900,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 223, 83, 141)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 350,
                          ),
                          Text(
                            '${data["pname"]}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data["pprice"]} \$',
                              style: TextStyle(color: defaultColor)),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${data["pdescription"]}'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: MaterialButton(
                        onPressed: () {
                          var db = FirebaseFirestore.instance
                              .collection("CartItems")
                              .doc(data["id"]);
                          var json = {
                            "pid": data["id"],
                            "pname": data["pname"],
                            "image": data["image"],
                            "pprice": data["pprice"],
                            "pdescrition": data["pdescription"]
                          };
                          db.set(json).then((value) => print("Record Added"));


                          Fluttertoast.showToast(
                              msg: "Added to Cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green.shade700,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add to Cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        color: defaultColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

