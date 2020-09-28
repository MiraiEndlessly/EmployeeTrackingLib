import 'package:flutter/material.dart';
import 'authentication.dart';
import 'root_page.dart';
import 'service_locator.dart';

void main() {
  setupLocator();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: new BaseAuth()));
  }
}
