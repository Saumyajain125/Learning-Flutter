import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class sign_in extends StatefulWidget {
  @override
  _sign_inState createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  TextEditingController _mobileController;
  TextEditingController _nameController;
  String verifID;
  void initState(){
    super.initState();
    Firebase.initializeApp();
    _mobileController = TextEditingController();
    _nameController = TextEditingController();
  }
  void _sendOTP() async {
    String mobile = this._mobileController.value.text;
    var auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: Duration(seconds: 30),
      codeSent: (String verifId, int val) {
        print('In Code Sent');
        print(verifId);
        this.verifID = verifId;
        print(val);
      },
      codeAutoRetrievalTimeout: (String verifId) {
        // print(FirebaseAuth.instance.currentUser.phoneNumber);
        print('In Auto Retrieval Timeout');
        print(verifId);
      },
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print("Verifed hurray ---------------------------------");
      },
      verificationFailed: (error) {
        print('In Verfication Failed');
        print(error);
      },
    );
  }
  verifyOtp(String verificationId, String otp) {
    if (otp.length != 6) return null;
    if (verificationId.isEmpty) return null;
    var cred = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    verificationCompleted(cred);
    // return Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
  void verificationCompleted(phoneAuthCredential) {
    var auth = FirebaseAuth.instance;
    print('In Verification Completed');
    print(phoneAuthCredential.smsCode);
    print(phoneAuthCredential.verificationId);
    auth.signInWithCredential(phoneAuthCredential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTextField(_mobileController,"Enter Your Name","Name"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTextField(_mobileController,"Enter Phone Number","Phone Number"),
            ),
            ElevatedButton(
                onPressed: _sendOTP,
                child: Text("Get OTP"),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildTextField(controller,string1,string2) {
    return TextField(

            controller: controller,
            decoration: InputDecoration(
              hintText: string1,
              labelText: string2,
              focusColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
          );
  }
}
