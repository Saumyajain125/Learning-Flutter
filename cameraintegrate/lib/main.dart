import 'package:cameraintegrate/firebasee.dart';
import 'package:cameraintegrate/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:cameraintegrate/forms.dart';
import 'package:cameraintegrate/home.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home(),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<CameraDescription> _cameras;
  CameraController _controller;

  void _getCameras() async {
    this._cameras = await availableCameras();
    if (this._cameras.isNotEmpty) {
      print(this._cameras);
      this._controller = new CameraController(
        this._cameras.first,
        ResolutionPreset.max,
      );
      await this._controller.initialize();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._getCameras();
  }

  void _captureImage() async {
    XFile file = await this._controller.takePicture();
    print("-------");
    print(file.path);
    print("-------");
  }
  void camerawidget(){

  }
  @override
  Widget build(BuildContext context) {
    // print(this._controller.value);
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Integration'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            this._controller != null && this._controller.value.isInitialized
              ? Center(child: Container(height: 300,width: MediaQuery.of(context).size.width*.7,child: CameraPreview(this._controller)))
              : Container(),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image'),
            ),
            // Container(
            //   height: 300,
            //   width: MediaQuery.of(context).size.width*.7,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("$this.file.path"),
            //       fit: BoxFit.contain,
            //       )
            //     )
            //   ),
            InkWell(
              child: Container(
                height: 100,
                width: 100,
                child: Center(child: Text("Next"))
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => forms()));
              }
            )
          ],
        ),
      ),
    );
  }
}
