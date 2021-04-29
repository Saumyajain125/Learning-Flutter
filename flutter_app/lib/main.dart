import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _like = 0;
  var num = TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter() =>
      setState(() {
        _counter--;
      });

  void _resetCounter() =>
      setState(()
      {
         _counter = 0;
      });
  void _startvalue(int a){
    setState(() {
      _counter = a;
    });
  }
  void _likeCounter() {
    setState(() {
      _like++;
      print(_like);
    });
  }
  void _dislikeCounter() {
    setState(() {
      _like--;
      print(_like);
    });
  // }
  // void initState() {
  //   super.initState();
  //   _numberCtrl.text = "085921191121";
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: false,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Incrementer Decrementer"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Give your own starting value:",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: num,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              InkWell(
                child: Container(
                  height: 60,
                  color: Colors.red,
                  width: 300,
                  child: Center(child: Text("SUBMIT",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                ),
                onTap: () =>
                    // _startvalue(setValue())
                _startvalue(setValue())
                ,
              ),
              Text(
                'Increment and Decrement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                '$_counter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
                // style: Theme
                //     .of(context)
                //     .textTheme
                //     .headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildFloatingActionButton(_incrementCounter,Icons.add),
                  buildFloatingActionButton(_decrementCounter,Icons.minimize_outlined),
                ],
              ),
              buildFloatingActionButton(_resetCounter,Icons.refresh_sharp),
              Text(
                "Liked my App? Give it a Like",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.thumb_up_sharp,
                            color: Colors.white
                        ),
                      ),
                          onTap: () => _likeCounter(),
                  ),
                  InkWell(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.thumb_down_sharp,
                            color:Colors.white
                        ),
                      ),
                    onTap: () => _dislikeCounter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("$_like"),
                ],
              ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                final snackBar = SnackBar(
                    content: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.red,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/callimage.jpg"),
                              fit: BoxFit.cover,
                            )
                          ),
                          child: Center(
                            child: InkWell(
                              child: Text(
                                "Really?",
                                style: TextStyle(
                                    fontSize: 21,
                                    backgroundColor: Colors.black,
                                ),
                              ),
                              onTap: _callNumber,
                            ),
                          ),
                        )
                      ],
                    )
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Call Number'),
            ),
          ),
            ],
          ),
        ),
      );
    }
    int setValue(){
      int b = int.parse(num.text);
      return b;
    }
    FloatingActionButton buildFloatingActionButton(fun,ic) {
      return FloatingActionButton(
              onPressed: fun,
              tooltip: 'Decrement',
              child: Icon(ic),
              backgroundColor: Colors.red,
              hoverColor: Colors.blue,
              focusColor: Colors.blue,
              hoverElevation: 20,
            );
    }
  _callNumber() async{
    const number = '94148695'; //set the number here
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  }