import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home/home.dart';

const apiKey = '16008883-55bdb86ddba89e3fb7dbf85f0';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
