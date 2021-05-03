import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class sharedpreferences extends StatefulWidget {
  @override
  _sharedpreferencesState createState() => _sharedpreferencesState();
}
class _sharedpreferencesState extends State<sharedpreferences> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fnController,
    _lnController,
    _emailController,
    _mobileController;
  FirebaseFirestore firestore;
  void _initFireStore() async {
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
  }
  @override
  void initState() {
    super.initState();
    this._fnController = TextEditingController();
    this._lnController = TextEditingController();
    this._emailController = TextEditingController();
    this._mobileController = TextEditingController();
    _initFireStore();
  }
  void addDoc() async{
    Map<String, dynamic> data1 = {
      "First Name" : this._fnController.text,
      "Second Name" : this._lnController.text,
      "mobile" : this._mobileController.text,
      "email" : this._emailController.text,
  };
  await firestore.collection('FormData').add(data1);
  print("Success");
  setState(() {});
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('User Details'),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextFormField(
                    controller: this._fnController,
                    validator: (value) {
                      if (value.isNotEmpty)
                        return null;
                      else
                        return 'Enter your First name';
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter First name here',
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextFormField(
                    controller: this._lnController,
                    validator: (value) {
                      if (value.isNotEmpty)
                        return null;
                      else
                        return 'Enter your last name';
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Last name here',
                      labelText: 'Last Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextFormField(
                    controller: this._emailController,
                    validator: (value) {
                      if (value.contains('@') && value.contains('.com'))
                        return null;
                      else
                        return 'Email is not correct';
                    },
                    decoration: InputDecoration(
                      hintText: 'Email here',
                      labelText: 'Enter Email here',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextFormField(
                    controller: this._mobileController,
                    validator: (value) {
                      if (value.length == 10)
                        return null;
                      else
                        return 'Mobile number length should be equal to 10';
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Mobile here',
                      labelText: 'Mobile Number',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: this.addDoc,
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}