import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_2_go/screens/details/components/cartpage.dart';
import 'package:rent_2_go/screens/details/profile.dart';
import 'package:rent_2_go/screens/home/home_screen.dart';
import 'package:rent_2_go/screens/search/search_widget.dart';
import './main.dart';

import 'add_products.dart';
import 'constants.dart';
import 'login.dart';
import 'mainpage.dart';

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({Key? key, required this.isAuthenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ren2Go',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.yellow,
        fontFamily: "Gordita",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Color.fromARGB(255,226, 183, 19)),
        ),
      ),
      home: const MainPage(),
    );
  }
}

Future<bool> performAuthenticationCheck() async {
  User? user = FirebaseAuth.instance.currentUser;
  return user != null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Perform authentication check
  bool isAuthenticated = await performAuthenticationCheck();

  runApp(MyApp(isAuthenticated: isAuthenticated));
}