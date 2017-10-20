import 'dart:convert';

import 'package:firestore_chat/model/User.dart';
import 'package:firestore_chat/ui/homepage/HomePage.dart';
import 'package:firestore_chat/ui/loginpage/LoginPage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  var _routes = <String, WidgetBuilder>{
//    HomePage.routeName : (BuildContext context) => new HomePage(),
    LoginPage.routeName : (BuildContext context) => new LoginPage()
  };

//  Route<Null> _getRoute(RouteSettings settings) {
//    final List<String> path = settings.name.split('/');
//
//    if(path[0] != '')
//      return null;
//
//    if(path[1].startsWith('HomePage:')){
//      if(path.length != 2)
//        return null;
//
//      final Map map = JSON.decode(path[1].substring(9));
//      return new MaterialPageRoute<Null>(
//        builder: (BuildContext context) => new HomePage(map),
//        settings: settings
//      );
//    }
//
//    return null;
//  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Firestore Chat Flutter",
      routes: _routes,
//      onGenerateRoute: _getRoute,
      theme: new ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orangeAccent[400]
      ),
      home: new LoginPage(),
    );
  }
}
