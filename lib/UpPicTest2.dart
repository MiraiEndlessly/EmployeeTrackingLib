import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Capture',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _containerKey = GlobalKey();
  StorageReference storageReference = FirebaseStorage().ref();
  bool loading = false;

  void convertWidgetToImage() async {
    RenderRepaintBoundary renderRepaintBoundary = _containerKey.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
    ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uInt8List = byteData.buffer.asUint8List();
    this.setState(() {
      loading = true;
    });
    StorageUploadTask storageUploadTask = storageReference
        .child("IMG_${DateTime.now().millisecondsSinceEpoch}.png")
        .putData(uInt8List);

    await storageUploadTask.onComplete;
    this.setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Capture"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RepaintBoundary(
              key: _containerKey,
              child: Container(
                  decoration:
                  BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey)),
                  width: size.width - 50,
                  height: size.height * 0.70,
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        "assets/confetti.png",
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/tick.png",
                            width: size.width / 3,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "50 \$",
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "To: Josh",
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "March 28, 2020 | 05:56 PM",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "TXNID: 754125698221",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Company: Your Company",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      (loading)
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : Center()
                    ],
                  )),
            ),
            MaterialButton(
                color: Colors.deepOrange,
                child: Text(
                  "Share",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  convertWidgetToImage();
                })
          ],
        ),
      ),
    );
  }
}
