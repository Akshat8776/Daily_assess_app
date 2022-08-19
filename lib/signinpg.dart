import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:collection/collection.dart';
import 'package:login_logout/signuppage.dart';
import 'homepg.dart';
import 'package:provider/provider.dart';
import 'google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String name = "";
  String password = "";
  String joinid = "";
  Map<String, String> map = {};

  Future<void> load() async {
    final abcd = await FirebaseDatabase.instance.ref("Logins").ref;

    late Map<dynamic, dynamic> a;
     var dataSnapshot = await abcd.get()
      ..children.toList(growable: false).forEachIndexed((index, value) {
        print('$index: ${value.value} : ${value.key}');
        if (value.key == "joiningid") {
          joinid = '${value.value}';
        } else {
          a = value.value as Map<dynamic, dynamic>;

          name = a["name"];
          password = a["password"];
          map.addAll({name: password});
          // print("Hi");
          // print(a.values);
          // epo.add(a["epochtime"]);
          // temp.add(a["temprature"].round());
          // humi.add(a["humidity"].round());
        }
      });

    //      .then((DatabaseEvent event){
    //
    //   values = event.snapshot.value as Map<dynamic,dynamic>;
    //   values.forEach((key,values) {
    //       print(values["epochtime"].toString());
    //   });
    // });
    // i=1;
  }

  @override
  void initState() {
    // TODO: implement initState
    load();
    super.initState();
  }

  final Map<int, Widget> children = <int, Widget>{
    0: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 15),
      ),
    ),
    1: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Text(
        'Signup',
        style: TextStyle(fontSize: 15),
      ),
    ),
  };
  int sharedvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 330,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSlidingSegmentedControl(
                  groupValue: sharedvalue,
                  onValueChanged: (int? index) {
                    setState(
                      () {
                        sharedvalue = index!;
                      },
                    );
                  },
                  children: children,
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: sharedvalue == 0,
                  child: Column(
                    children: [
                      const Text(
                        "Enter the name                ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                            controller: namecont,
                            decoration: const InputDecoration(
                              labelText: "",
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Enter the password         ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                            controller: passcont,
                            decoration: const InputDecoration(
                              labelText: "",
                              hintText: "Enter the password",
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (map.containsKey(namecont.text)) {
                              if (passcont.text == map[namecont.text]) {
                                print(map.toString());
                                print("LoginSuccessful");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoggedIn(
                                              name: namecont.text,
                                            )));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Invalid password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.greenAccent,
                                    fontSize: 16.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Invalid name",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.greenAccent,
                                  fontSize: 16.0);
                            }
                          },
                          child: Container(
                            child: const Text("Submit"),
                            color: Colors.blue,
                          )),
                      ElevatedButton.icon(
                        onPressed: () async{
                          final provider= await Provider.of<GoogleSignInProvider>(context,listen: false);
                          await provider.googleLogin();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup(
                                  )));
                        },
                        icon: const FaIcon(FontAwesomeIcons.google,color: Colors.red,),
                        label: const Text("Sign in with google"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(5),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: sharedvalue == 1,
                  child: Column(
                    children: [
                      const Text(
                        "Enter the name                ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                            controller: namecont2,
                            decoration: const InputDecoration(
                              labelText: "",
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Enter the password         ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                            controller: passcont2,
                            decoration: const InputDecoration(
                              labelText: "",
                              hintText: "Enter the password",
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Enter the joining id         ",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                            controller: joining,
                            decoration: const InputDecoration(
                              labelText: "",
                              hintText: "Enter the joining id",
                              labelStyle: TextStyle(
                                  fontSize: 20, color: Colors.black),
                              border: OutlineInputBorder(),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (map.containsKey(namecont2.text) == false &&
                                namecont2.text.length > 0 &&
                                passcont2.text.length >= 4) {
                              if (joining.text == joinid) {
                                upd();
                                Fluttertoast.showToast(
                                    msg: "Registration Successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.greenAccent,
                                    fontSize: 16.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Invalid join id",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.greenAccent,
                                    fontSize: 16.0);
                              }
                            } else if (map.containsKey(namecont2.text)) {
                              Fluttertoast.showToast(
                                  msg: "Name already found",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.greenAccent,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Registration unsuccessful",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.greenAccent,
                                  fontSize: 16.0);
                              print("Joinid");
                              print(joinid);
                            }
                          },
                          child: Container(
                            child: const Text("Register"),
                            color: Colors.blue,
                          )),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> upd() async {
    final abcd = await FirebaseDatabase.instance.ref("Logins").ref;
    Map<dynamic, dynamic> values;
    await abcd.once().then((DatabaseEvent event) {
      values = event.snapshot.value as Map<dynamic, dynamic>;
      var newname = {
        "Login${map.length}": {
          "name": namecont2.text,
          "password": passcont2.text
        }
      };
      values.addAll(newname);
      abcd.set(values);
    });
    map.addAll({namecont2.text: passcont2.text});
    newreg();
  }

  Future<void> newreg() async {
    final abcd = await FirebaseDatabase.instance.ref("Data").ref;
    Map<dynamic, dynamic> values;
    await abcd.once().then((DatabaseEvent event) {
      values = event.snapshot.value as Map<dynamic, dynamic>;
      var newname = {
        namecont2.text: {
          DateTime.now().toString().replaceAll(".", ""): {"Welcome": "hey"}
        }
      };
      values.addAll(newname);
      abcd.set(values);
    });
    map.addAll({namecont2.text: passcont2.text});
  }

  TextEditingController namecont = TextEditingController(text: "");
  TextEditingController passcont = TextEditingController(text: "");
  TextEditingController namecont2 = TextEditingController(text: "");
  TextEditingController passcont2 = TextEditingController(text: "");
  TextEditingController joining = TextEditingController(text: "");
}

