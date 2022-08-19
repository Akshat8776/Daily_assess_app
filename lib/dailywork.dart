import 'dart:convert';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:collection/collection.dart';
import 'signinpg.dart';

class DailyWork extends StatefulWidget {
  DailyWork({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<DailyWork> createState() => _DailyWorkState();
}

class _DailyWorkState extends State<DailyWork> {
  TextEditingController entry = TextEditingController(text: "");
  TextEditingController topiccont = TextEditingController(text: "");
  final referenceDatabase = FirebaseDatabase.instance;
  final movcontroller = TextEditingController();
  late dynamic _referen;
  @override
  void initState() {
    // TODO: implement initState
    final FirebaseDatabase db = FirebaseDatabase.instance;
    _referen = db.ref().child("Data").child(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          openDialog();
        },
      ),
      body: Column(
        children: [
          Flexible(
            child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: _referen,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  // var values = snapshot.value as Map<dynamic, dynamic>;
                  print(snapshot.key.toString());
                  return Column(
                    children: [
                      Container(
                        height: 5,
                        color: Colors.grey,
                      ),
                      Card(
                        child: ListTile(
                          subtitle:
                              Text(snapshot.value.toString().split("{")[1].split("}")[0]),
                          tileColor: Colors.transparent,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  Future<void> newentry() async {
    final abcd = await FirebaseDatabase.instance.ref("Data/${widget.name}").ref;
    Map<dynamic, dynamic> values;
    await abcd.once().then((DatabaseEvent event) {
      values = event.snapshot.value as Map<dynamic, dynamic>;
      var newname = {
        DateTime.now().toString().replaceAll(".", ""): {
          topiccont.text: entry.text
        }
      };
      values.addAll(newname);
      abcd.set(values);
      setState(() {});
    });
  }
  var formKey = GlobalKey<FormState>();
  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Aj kya kiya'),
          content: Form(
            key: formKey,
            child: Column(
              children: [
                Text(widget.name),
                const Text("Enter the Topic                ",style: TextStyle(fontSize: 20),),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: TextFormField(
                      controller: topiccont,
                      decoration: const InputDecoration(
                        labelText: "",
                        labelStyle:
                        TextStyle(fontSize: 20, color: Colors.black),
                        border: OutlineInputBorder(),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Enter the Entry                ",style: TextStyle(fontSize: 20),),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: TextFormField(
                      controller: entry,
                      decoration: const InputDecoration(
                        labelText: "",
                        labelStyle:
                        TextStyle(fontSize: 20, color: Colors.black),
                        border: OutlineInputBorder(),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed: (){newentry();Navigator.of(context).pop();}, child: Text("Press me")),

              ],
            ),

          )));
}
// keytool -list -v -alias androiddebugkey -keystore debug.keystore
// keytool -list -v -alias androiddebugkey -keystore \debug.keystore
// 31:8D:C4:AE:08:49:DF:F7:CD:93:44:46:42:AE:14:45:52:AE:71:6D
// SHA256: F1:DD:4C:AE:7B:17:D1:99:FF:57:C1:27:50:75:FD:5C:CC:77:CE:90:24:1F:45:CB:EE:D5:2F:90:62:A6:23:DF