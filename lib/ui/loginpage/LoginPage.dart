import 'dart:convert';

import 'package:firestore_chat/model/User.dart';
import 'package:firestore_chat/ui/homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class LoginPage extends StatelessWidget {

  static const String routeName= "/LoginPage";

  final googleSignIn = new GoogleSignIn();

  final auth = FirebaseAuth.instance;

  BuildContext mContext;

  Future<Null> _googleSignIn() async{

    GoogleSignInAccount user = googleSignIn.currentUser;

    if(user == null)
      user = await googleSignIn.signInSilently();

    if(user == null){
      await googleSignIn.signIn();
    }

    if(await auth.currentUser() == null){
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(idToken: credentials.idToken, accessToken: credentials.accessToken,);
      User user = getUser(googleSignIn.currentUser.id.toString(), googleSignIn.currentUser.displayName, googleSignIn.currentUser.photoUrl);
      Navigator.pushReplacementNamed(mContext, '/HomePage:${JSON.encode({'id': user.uid, 'name': user.displayName})}');
//      Navigator.pushReplacementNamed(mContext, '/HomePage:${user}');
    }


  }

  @override
  Widget build(BuildContext context) {

    mContext = context;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      body: new Container(
        child: new Center(
          child: new RaisedButton(
            onPressed: _onPressed,
            child: new Text("Google"),
          ),
        ),
      ),
    );
  }

  void _onPressed(){
    _googleSignIn();
  }

  User getUser(String uid, String displayName, String photoUrl) {
    return new User(uid, displayName, photoUrl);
  }
}
