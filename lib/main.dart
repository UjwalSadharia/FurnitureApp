import 'package:flutter/material.dart';
import 'package:furnitureapp/Screens/Welcome/welcome_screen.dart';
import 'package:furnitureapp/Screens/Welcome/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitureapp/Screens/cart.dart';
import 'package:furnitureapp/Screens/homePage.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var user = FirebaseAuth.instance.currentUser;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: FirebaseAuth.instance.currentUser == null ? '/signin' : '/homepage',

      routes: {
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const WelcomeScreen(),
        '/cart': (context) => const cartpage(),
        '/homepage': (context) => HomePage(
              user: FirebaseAuth.instance.currentUser?.email,
            )
      },
      theme: ThemeData(fontFamily: GoogleFonts.montserrat().toString()),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? const WelcomeScreen() : HomePage(),
    );
  }
}
