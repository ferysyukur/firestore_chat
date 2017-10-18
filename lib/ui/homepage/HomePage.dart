import 'package:flutter/material.dart';
import 'package:firestore_chat/ui/homepage/ChatMessageView.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_firestore/firebase_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'dart:io';
import 'dart:math';


class HomePage extends StatefulWidget {

  static const String routeName = "/HomePage";

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final analitycs = new FirebaseAnalytics();

  final googleSignIn = new GoogleSignIn();

  GoogleSignInAccount user;

  final auth = FirebaseAuth.instance;

  var collection = Firestore.instance.collection("messages");

  final TextEditingController _textController = new TextEditingController();

  bool _isComposing = false;

  Future<Null> _handleSubmitted(String text) async{

    _textController.clear();

    setState((){
      _isComposing = false;
    });

    await _ensureLoggedIn();

    _sendMessage(text: text);
  }

  void _sendMessage({String text, String imageUrl}) {
    collection.document().setData({
      'uid': googleSignIn.currentUser.id,
      'senderImage': googleSignIn.currentUser.photoUrl,
      'sender': googleSignIn.currentUser.displayName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': new DateTime.now().millisecondsSinceEpoch
    });
    analitycs.logEvent(name: "send_message");
  }

  Future<Null> _ensureLoggedIn() async{

    user = googleSignIn.currentUser;

    if(user == null)
      user = await googleSignIn.signInSilently();

    if(user == null){
      await googleSignIn.signIn();
      analitycs.logLogin();
    }

    if(await auth.currentUser() == null){
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(idToken: credentials.idToken, accessToken: credentials.accessToken,);
    }
  }

  @override
  Widget build(BuildContext context) {

    if(user != null){

      String uid = user.id.toString();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Friendly Chat Firestore"),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                  child: new ChatMessageView(uid)
              ),
              new Divider(height: 1.0),
              new Container(
                  decoration: new BoxDecoration(
                      color: Theme.of(context).cardColor
                  ),
                  child: _buildTextComposer()
              ),
            ],
          ),
        ),
      );
    }else{
      return new Text("User Not Login");
    }

  }

  _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
            color: Theme.of(context).accentColor
        ),
        child: new Container(
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.photo_camera),
                    onPressed: () async{
                      await _ensureLoggedIn();
                      File imageFile = await ImagePicker.pickImage();
                      int random = new Random().nextInt(100000);
                      StorageReference ref = FirebaseStorage.instance.ref().child("image_$random.jpg");
                      StorageUploadTask uploadTask = ref.put(imageFile);
                      Uri downloadUrl = (await uploadTask.future).downloadUrl;
                      _sendMessage(imageUrl: downloadUrl.toString());
                    }
                ),
              ),
              new Flexible(child: new TextField(
                  controller: _textController,
                  onChanged: (String text){
                    setState((){
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _handleSubmitted,
                  decoration: new InputDecoration.collapsed(hintText: "Send a message")
              )
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: _isComposing ?
                        () => _handleSubmitted(_textController.text):
                    null
                ),
              )
            ],
          ),
        )
    );
  }
}
