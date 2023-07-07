import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import '../constants.dart';
import '../models/product_model.dart';
import 'Welcome/welcome_screen.dart';
import 'details_screen.dart';

class HomePage extends StatefulWidget {
  final String? user;
  HomePage({Key? key, this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List categories = ['All', 'Sofa', 'park bench', 'ArmChair'];
int selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  late String username = widget.user.toString();
  String name = "";
  // late List<QueryDocumentSnapshot> tempData;
  // late List<QueryDocumentSnapshot> updateRec;
  // late List<QueryDocumentSnapshot> search;
  // late DocumentSnapshot documentSnapshot;
  var txt1 = TextEditingController();




  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;




    return Scaffold(
      //DRAWER START
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/userr.png"),
                    radius: 55,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Welcome, ${username}"),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListTile(
                leading: Icon(Icons.shopping_cart,
                    color: Colors.orange.shade800, size: 30),
                title: Text('Cart',
                    style:
                        TextStyle(fontSize: 20, color: Colors.orange.shade900)),
                onTap: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: ListTile(
                leading:
                    Icon(Icons.lock, color: Colors.orange.shade800, size: 30),
                title: Text('Logout',
                    style:
                        TextStyle(fontSize: 20, color: Colors.orange.shade900)),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
      //DRAWER END

      backgroundColor: Colors.orange.shade900,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade900,
        elevation: 0.0,
        title: Text('Furniture'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/cart');
              },
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  onChanged: (value) => setState(() {
                    name = value;
                  }),
                  controller: txt1,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              height: 30.0,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: selectedIndex == index
                              ? Colors.white.withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  separatorBuilder: (context, index) => Container(
                        width: 1.0,
                      ),
                  itemCount: categories.length),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      color: Colors.white),
                ),
                // ListView.separated(
                //     physics: BouncingScrollPhysics(),
                //     itemBuilder: (context, index) =>buildCatItem(products[index], context, index),
                //     separatorBuilder: (context, index) => Container(width: 1.0),
                //     itemCount: products.length),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Products')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  

                    if (snapshot.hasError) {
                      return Text("Something Went Wrong!!");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                         DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                         if(name.isEmpty){
                           return InkWell(
                             onTap: () {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => DetailsScreen(
                                         id: documentSnapshot["id"],
                                       )));
                             },
                             child: Stack(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(35.0),
                                   child: Container(
                                     padding:
                                     EdgeInsets.only(right: 20, left: 20),
                                     height: 120,
                                     decoration: BoxDecoration(
                                         boxShadow: [
                                           BoxShadow(
                                               blurRadius: 10.0,
                                               color: Colors.grey)
                                         ],
                                         color: defaultColor,
                                         borderRadius:
                                         BorderRadius.circular(20)),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(35.0),
                                   child: Container(
                                     margin: EdgeInsets.only(right: 10),

                                     //  padding: EdgeInsets.only(right: 20,left: 20),
                                     height: 120,
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius:
                                         BorderRadius.circular(20)),
                                   ),
                                 ),
                                 Positioned(
                                   left: 150,
                                   child: Hero(
                                     tag: '${documentSnapshot["id"]}',
                                     child: Container(
                                       height: 160,
                                       width: 200,
                                       child: Image.asset(
                                         'assets/images/${documentSnapshot["image"]}',
                                       ),
                                     ),
                                   ),
                                 ),
                                 Positioned(
                                     top: 115,
                                     left: 35,
                                     child: Container(
                                       height: 40,
                                       width: 80,
                                       alignment: Alignment.center,
                                       child: Text(
                                           '${documentSnapshot["pprice"]} \₹'),
                                       decoration: BoxDecoration(
                                         color: defaultColor,
                                         borderRadius: BorderRadius.only(
                                           topRight: Radius.circular(40),
                                           bottomLeft: Radius.circular(20),
                                         ),
                                       ),
                                     )),
                                 Positioned(
                                     bottom: 100,
                                     left: 37,
                                     child: Text(
                                       '${documentSnapshot["pname"]}',
                                       style: TextStyle(fontSize: 11),
                                     )),
                               ],
                             ),
                           );
                         }
                         if(documentSnapshot["pname"].toString().contains(name)){
                           return InkWell(
                             onTap: () {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => DetailsScreen(
                                         id: documentSnapshot["id"],
                                       )));
                             },
                             child: Stack(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(35.0),
                                   child: Container(
                                     padding:
                                     EdgeInsets.only(right: 20, left: 20),
                                     height: 120,
                                     decoration: BoxDecoration(
                                         boxShadow: [
                                           BoxShadow(
                                               blurRadius: 10.0,
                                               color: Colors.grey)
                                         ],
                                         color: defaultColor,
                                         borderRadius:
                                         BorderRadius.circular(20)),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(35.0),
                                   child: Container(
                                     margin: EdgeInsets.only(right: 10),

                                     //  padding: EdgeInsets.only(right: 20,left: 20),
                                     height: 120,
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius:
                                         BorderRadius.circular(20)),
                                   ),
                                 ),
                                 Positioned(
                                   left: 150,
                                   child: Hero(
                                     tag: '${documentSnapshot["id"]}',
                                     child: Container(
                                       height: 160,
                                       width: 200,
                                       child: Image.asset(
                                         'assets/images/${documentSnapshot["image"]}',
                                       ),
                                     ),
                                   ),
                                 ),
                                 Positioned(
                                     top: 115,
                                     left: 35,
                                     child: Container(
                                       height: 40,
                                       width: 80,
                                       alignment: Alignment.center,
                                       child: Text(
                                           '${documentSnapshot["pprice"]} \₹'),
                                       decoration: BoxDecoration(
                                         color: defaultColor,
                                         borderRadius: BorderRadius.only(
                                           topRight: Radius.circular(40),
                                           bottomLeft: Radius.circular(20),
                                         ),
                                       ),
                                     )),
                                 Positioned(
                                     bottom: 100,
                                     left: 37,
                                     child: Text(
                                       '${documentSnapshot["pname"]}',
                                       style: TextStyle(fontSize: 11),
                                     )),
                               ],
                             ),
                           );
                         }
                          return Container();
                        },
                        separatorBuilder: (context, index) =>
                            Container(width: 1.0),
                        itemCount: snapshot.data!.docs.length);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );

  }


  // searchProd(String query) {
  //
  //   if (txt1 == '') {
  //     tempData = search;
  //   } else {
  //     tempData = search
  //         .where((element) => element["pname"].toString().contains(query))
  //         .toList();
  //   }
  //
  //   // setState(() {
  //   //   updateRec = tempData;
  //   // });
  //
  //   // if(search != null){
  //   //   print("HEREEEEEE");
  //   //   search.forEach((element) {
  //   //     if(element["pname"].toString().contains(query) == true){
  //   //       print(element["pname"]);
  //   //     }
  //   //   });
  //   // }
  // }
}
