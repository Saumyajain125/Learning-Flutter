import 'package:cameraintegrate/forms.dart';
import 'package:cameraintegrate/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cameraintegrate/forms.dart';
class otpscreen extends StatefulWidget {
  @override
  _otpscreenState createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  String verifID;
  bool buttonPushed = false;
  @override
  void initState(){
    super.initState();
    Firebase.initializeApp();
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
        print('In Auto Retrieval Timeout');
        print(verifId);
      },
      verificationCompleted: verificationCompleted,
      verificationFailed: (error) {
        print('In Verfication Failed');
        print(error);
      },
    );
  }
  void verificationCompleted(phoneAuthCredential) {
    var auth = FirebaseAuth.instance;
    print('In Verification Completed');
    print(phoneAuthCredential.smsCode);
    print(phoneAuthCredential.verificationId);
    auth.signInWithCredential(phoneAuthCredential);
  }

  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser.phoneNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _mobileController,
            keyboardType: TextInputType.text,
          ),
          ElevatedButton(onPressed: _sendOTP, child: Text("Get")),
          TextField(
            controller: _otpController,
          ),
          ElevatedButton(onPressed: () => verifyOtp(verifID, _otpController.value.text),child: Text("Verify OTP"),),
          // InkWell(
          //       child: Container(
          //         color: Colors.yellow,
          //         height: 90,
          //         width: 90,
          //       ),
          //       onTap: (){
          //
          //       }
          //   ),
        ],
      ),
    );
  }
  verifyOtp(String verificationId, String otp) {
    if (otp.length != 6) return null;
    if (verificationId.isEmpty) return null;
    var cred = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    verificationCompleted(cred);
    return Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }
}
