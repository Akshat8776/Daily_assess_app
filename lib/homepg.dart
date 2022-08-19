import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:collection/collection.dart';
import 'signinpg.dart';
import 'dailywork.dart';

class LoggedIn extends StatefulWidget {
   LoggedIn({Key? key,required this.name}) : super(key: key);
  String name;

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(child: Container(padding:EdgeInsets.all(10),child: Icon(Icons.logout)),onTap: (){
            Navigator.pop(context);
            // MaterialPageRoute(
            //   builder: (context) =>
            //   const SignInPage())
          ;},),

        ],
      ),
      body: Center(
        child:Container(
          child: GestureDetector(child: Container(height:50,color:Colors.blueAccent,child: Text("Press me",style: TextStyle(fontSize: 28),)),onTap: (){
            print(widget.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                     DailyWork(name: widget.name,)));
          },),
        )
      ),
    );
  }
}
