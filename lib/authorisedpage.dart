import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Authorised extends StatefulWidget {
  const Authorised({Key? key}) : super(key: key);

  @override
  State<Authorised> createState() => _AuthorisedState();
}

class _AuthorisedState extends State<Authorised> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text("Congratulations!!!You are authorised for this page",style: TextStyle(color: Colors.pinkAccent,fontSize: 24),)
        ],
      ),
    );
  }
}
