import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:facebook_sign_in/facebook_sign_in.dart'; // Import Facebook Login plugin.
import 'package:firestore_chat/User.dart';
import 'package:firestore_chat/TestPas.dart';

final auth = FirebaseAuth.instance;
final googleSignIn = new GoogleSignIn();


final List<String> read = ["public_profile", "user_friends", "email"];

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
              onTap: _loginGoogle,
            ),
            new GestureDetector(
              child:  new Image(
                image: new AssetImage("image/fb.png"),
                height: 60.0,
                width: 300.0,
              ),
              onTap: _loginFacebook,
            ),

          ],
        ),
      ),
    );

  }

  Future<Null> _loginGoogle() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null)
      user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
    }
    if (await auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
      await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(
      idToken: credentials.idToken,
      accessToken: credentials.accessToken,
    );
    }

    User mUser = new User(user.displayName,user.email,user.photoUrl);
    print("Cek : "+mUser.email);
    print("Cek : "+mUser.name);
    print("Cek : "+mUser.photoUrl);

    //switch page to chat and passing model user

    Route route = new MaterialPageRoute(
      settings: new RouteSettings(name: "/todos/todo"),
      builder: (BuildContext context) => new TestPas(myuser: mUser)
    );
    Navigator.of(context).push(route);

  }

  Future<Null> _loginFacebook() async{
    String token = await FacebookSignIn.loginWithReadPermissions(read);
    print("token: " + token);
  }
}

