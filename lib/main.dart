import 'package:firestore_chat/ui/homepage/HomePage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firestore Chat Flutter",
      theme: new ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orangeAccent[400]
      ),
      home: new HomePage(),
    );
  }
}
