import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}

class Mylogin extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => new _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fluter Chat"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              child:  new Image(
                image: new AssetImage("image/gb.png"),
                height: 60.0,
                width: 300.0,

              ),
              onTap: _onTap,
            ),



            new GestureDetector(
              child:  new Image(
                image: new AssetImage("image/fb.png"),
                height: 60.0,
                width: 300.0,
              ),
              onTap: _onTap,
            ),

          ],
        ),
      ),
    );

  }

  void _onTap() {
   print("Tap");
  }
}

