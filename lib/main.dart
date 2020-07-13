import 'package:flutter/material.dart';
import 'package:sun/pages/MainPage.dart';
void main() => runApp(MaterialApp(
    title: "Music Player",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Bitter',
      primaryColor: Colors.pink,
    ),
    home: MyApp()));
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      body: MainPage(),
    );
  }
}
