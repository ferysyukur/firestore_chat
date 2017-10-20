import 'dart:convert';

import 'package:firestore_chat/model/User.dart';
import 'package:firestore_chat/ui/homepage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {

  static const String routeName= "/LoginPage";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final googleSignIn = new GoogleSignIn();

  final auth = FirebaseAuth.instance;

  BuildContext mContext;

  SharedPreferences pref;

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
      Map map = {'uid': googleSignIn.currentUser.id.toString(), 'displayName': googleSignIn.currentUser.displayName, 'photoUrl': googleSignIn.currentUser.photoUrl};
      User mUser = new User.fromMap(map);
      pref.setString('map', JSON.encode(mUser.toMap()));
      Navigator.pushReplacement(mContext, new MaterialPageRoute(builder: (_) => new HomePage(mUser: mUser,)));
//      Navigator.pushReplacementNamed(mContext, '/HomePage:${JSON.encode({'id': user.uid, 'name': user.displayName})}');
//      Navigator.pushReplacementNamed(mContext, '/HomePage:${user}');
    }


  }

  Future<Null> _checkLogin() async{
    pref = await SharedPreferences.getInstance();
    if(pref.getString("map") != null){
      Map map = JSON.decode(pref.getString("map"));
      User mUser = new User.fromMap(map);
      Navigator.pushReplacement(mContext, new MaterialPageRoute(builder: (_) => new HomePage(mUser: mUser,)));
    }
  }


  @override
  void initState() {
    _checkLogin();
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

//  User getUser(String uid, String displayName, String photoUrl) {
//    return new User(uid, displayName, photoUrl);
//  }
}

