import 'package:cameraintegrate/otpscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cameraintegrate/sharedprferences.dart';

class firebasee extends StatefulWidget {
  @override
  _firebaseeState createState() => _firebaseeState();
}

class _firebaseeState extends State<firebasee> {
  FirebaseFirestore firestore;
  void _initFireStore() async {
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
  }
  void getdata() async {
    CollectionReference ref = firestore.collection("Dummy");
    QuerySnapshot qs = await ref.get();
    qs.docs.forEach((doc) {
      print("----------------------------------");
      print(doc.data());
      print("----------------------------------");
    });
  }
  void addDoc() async{
    Map<String, dynamic> data = {
      "First Name" : "Shreyansh",
      "Second Name" : "Pareek",
      "mobile" : "9852549150",
      "email" : "shreyanahpareek30@gmail.com",
    };
    await firestore.collection('UserData').add(data);
    print("Success");
  }
  void initState(){
    super.initState();
    _initFireStore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: getdata,
                child: Text("Get Data"),
            ),
            ElevatedButton(
              onPressed: addDoc,
              child: Text("Add Data"),
            ),
            InkWell(
                child: Container(
                    height: 100,
                    width: 100,
                    child: Center(child: Text("Next"))
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => otpscreen()));
                }
            )
          ],
        ),
      ),
    );
  }
}
