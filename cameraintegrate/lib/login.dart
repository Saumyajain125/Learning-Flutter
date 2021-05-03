import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _mobileController;
  void initState(){
    super.initState();
    _mobileController = TextEditingController();
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
            buildTextField(_mobileController,"Enter your Mobile Number", "Mobile Number"),
            ElevatedButton(
                onPressed: (){},
                child: Text("Login")
            )
          ],
        ),
      ),
    );
  }
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

