import 'package:flutter/material.dart';
import 'package:firestore_chat/User.dart';

class TestPas extends StatefulWidget {
  TestPas({Key key, this.myuser}): super(key : key);
  final User myuser;
  @override
  _TestPasState createState() => new _TestPasState();
}

class _TestPasState extends State<TestPas> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(widget.myuser.name),
    );
  }
}
