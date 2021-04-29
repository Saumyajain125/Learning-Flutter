import 'package:cameraintegrate/firebasee.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class forms extends StatefulWidget {
  @override
  formsState createState() => formsState();
}
class formsState extends State<forms> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordShown = false;
  void _validate() {
    _formKey.currentState.validate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form validation'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.contains('@') || value.contains('.com'))
                    return null;
                  else
                    return 'Email is not correct';
                },
                decoration: InputDecoration(
                  hintText: 'Email here',
                  labelText: 'Enter Email here',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                validator: (value) {
                  if (value.length > 6)
                    return null;
                  else
                    return 'Password is not strong';
                },
                obscureText: !_passwordShown,
                decoration: InputDecoration(
                  hintText: 'Password here',
                  labelText: 'Enter Password here',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        _passwordShown = !_passwordShown;
                      });
                    },
                    color: Colors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: this._validate,
                child: Text('Validate'),
              ),
              InkWell(
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Center(child: Text("Next"))
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => firebasee()));
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}