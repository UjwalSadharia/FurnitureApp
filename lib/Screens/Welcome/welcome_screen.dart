import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitureapp/Screens/homePage.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange.shade900,
            Colors.orange.shade800,
            Colors.orange.shade400,
          ])),
          // child: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(255, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextFormField(
                                  controller: emailC,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Email";
                                    } else if (value.contains('@')) {
                                      return "Please Include @ in Id";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      errorStyle: TextStyle(color: Colors.red),
                                      hintText: "Email Id",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(255, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextFormField(
                                  controller: passwordC,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.orange.shade900,
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                await Firebase.initializeApp();
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailC.text,
                                        password: passwordC.text)
                                    .then((value) {
                                  debugPrint(value.user!.email);

                                  var cuser = FirebaseAuth.instance.currentUser;

                                  // Navigator.pushNamed(context, '/homepage');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(user: cuser!.email.toString(),)));
                                });
                                emailC.clear();
                                passwordC.clear();
                              } catch (e) {
                                Fluttertoast.showToast(
                                  msg: "Invalid Username or Password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              backgroundColor: Colors.orange.shade900,
                            ),
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: const Text(
                            "Don't have an account ? Sign Up",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // ),
        ));
  }
}
