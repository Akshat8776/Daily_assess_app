import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'homepg.dart';
import 'signinpg.dart';
import 'google_sign_in.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),
      child:  MaterialApp(
        theme: ThemeData.light().copyWith(
          iconTheme:  IconThemeData(size: 36.0, color: Colors.black87),
          textTheme:  TextTheme(
            bodyText2: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
        home: const SignInPage(),
      ),
    );
  }
}
