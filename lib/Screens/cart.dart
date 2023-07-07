import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furnitureapp/constants.dart';

class cartpage extends StatefulWidget {
  const cartpage({Key? key}) : super(key: key);

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("CartItems").snapshots(),
      builder: (context, snapshot) {


        if(snapshot.hasError){
          return Text("Sorry Something Went Wrong!!");
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }


        return Scaffold(
            appBar: AppBar(
              title: Text("My Cart"),
              backgroundColor: Colors.orange.shade900,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: ListView.separated(
              separatorBuilder: (context, index) => Container(height: 0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {

                var documentSnapshot = snapshot.data!.docs[index];

                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: ListTile(
                        leading: Image.asset("assets/images/${documentSnapshot["image"]}",),
                        title: Text('${documentSnapshot["pname"]}', style: TextStyle(fontSize: 20, color: Colors.white)),
                        subtitle: Text("${documentSnapshot["pprice"]}\₹"),
                        trailing: InkWell(
                          onTap: () {
                            FirebaseFirestore.instance.collection("CartItems").doc(documentSnapshot["pid"]).delete().then((value) => print("Item Removed From Cart"));
                          },
                          child: Icon(
                            Icons.highlight_remove_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ));
      },
    );
  }
}
