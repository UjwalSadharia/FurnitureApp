import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../homePage.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
          //   scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "SignUp",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Create an Account",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
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
                                  decoration: const InputDecoration(
                                      hintText: "Email Id",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                                  controller: passwordC,
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
                                    .createUserWithEmailAndPassword(
                                        email: emailC.text,
                                        password: passwordC.text);
                                var user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  await user.sendEmailVerification();
                                } else {
                                  debugPrint("Couldn't verify the email!");
                                }
                                emailC.clear();
                                passwordC.clear();
                              } on FirebaseAuthException catch (error) {
                                Fluttertoast.showToast(
                                  msg: "Unable to Create User",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              backgroundColor: Colors.orange.shade900,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Text(
                            "Already have an Account ? Sign In",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "____________________OR____________________",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // SVGS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black12)),
                              child: InkWell(
                                onTap: () async{
                                  FirebaseAuth auth = FirebaseAuth.instance;
                                  User? user;

                                  final GoogleSignIn googleSignIn = GoogleSignIn();

                                  final GoogleSignInAccount? googleSignInAccount =
                                      await googleSignIn.signIn();

                                  if (googleSignInAccount != null) {
                                    final GoogleSignInAuthentication googleSignInAuthentication =
                                        await googleSignInAccount.authentication;

                                    final AuthCredential credential = GoogleAuthProvider.credential(
                                      accessToken: googleSignInAuthentication.accessToken,
                                      idToken: googleSignInAuthentication.idToken,
                                    );

                                    try {
                                      final UserCredential userCredential =
                                          await auth.signInWithCredential(credential);
                                      var cuser = await FirebaseAuth.instance.currentUser;
                                          // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage(user:cuser!.email.toString())));
                                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>HomePage(user:cuser!.email.toString())) , (route) => false);
                                      user = userCredential.user;
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'account-exists-with-different-credential') {
                                        // handle the error here
                                      }
                                      else if (e.code == 'invalid-credential') {
                                        // handle the error here
                                      }
                                    } catch (e) {
                                      // handle the error here
                                    }
                                  }
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/google-plus.svg",
                                    color: Colors.orange),
                              ),
                            ),

                          ],
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
