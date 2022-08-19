import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'google_sign_in.dart';
import 'package:provider/provider.dart';
import 'signinpg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'authorisedpage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final user= FirebaseAuth.instance.currentUser;
  Color a=Colors.redAccent;
  @override
  void initState() {
    // TODO: implement initState
    if(user==null)Navigator.pop(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(child: const Text("Logout"),onTap: (){
            final provider= Provider.of<GoogleSignInProvider>(context,listen:false);
            provider.logout();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SignInPage()));

          },)
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:  CircularProgressIndicator(),);}
          else if(snapshot.hasError){
            return const Center(child:  Text("Something went wrong"),);
          }
          else if(user==null){
            return const Center();
          }
          else {
            if(user!.email=="akshat8776@gmail.com")a=Colors.blue;
            return Center(
              child: Container(
                height: 500,
                width: 350,
                color: Colors.grey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user!.photoURL!),
                    ),
                    const SizedBox(height: 15,),
                    Text(user!.displayName!,style: const TextStyle(fontSize: 18),),
                    const SizedBox(height: 15,),
                    Text(user!.email!,style: const TextStyle(fontSize: 18),),
                    ElevatedButton(onPressed: (){
                      if(user!.email=="akshat8776@gmail.com"){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const Authorised()));

                      }
                      else
                        {
                          Fluttertoast.showToast(
                              msg: "You are not authorised for this page",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.greenAccent,
                              fontSize: 16.0);
                        }
                    },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(a),foregroundColor: MaterialStateProperty.all(Colors.white)), child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                         Text("Press me"),
                        SizedBox(width: 5,),
                        Icon(Icons.lock)
                      ],
                    ),
                    )
                  ],
                ),
              ),
            );
          }

    }),
    );
  }
}
