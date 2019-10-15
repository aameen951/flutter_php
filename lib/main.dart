import 'package:flutter/material.dart';
import 'package:flutter_php/pages/main.dart';


class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter PHP",
      home: MainPage(),
    );
  }

}

void main() {
  runApp(App());
}