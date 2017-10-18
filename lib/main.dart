import 'package:firestore_chat/ui/homepage/HomePage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  var routes = <String, WidgetBuilder>{
    HomePage.routeName : (BuildContext context) => new HomePage()
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firestore Chat Flutter",
      routes: routes,
      theme: new ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orangeAccent[400]
      ),
      home: new HomePage(),
    );
  }
}
