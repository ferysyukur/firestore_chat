import 'package:flutter/material.dart';
import 'package:firebase_firestore/firebase_firestore.dart';

class ChatMessageView extends StatelessWidget {

  final String uid;

  ChatMessageView({this.uid});

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('messages').orderBy("timestamp", descending: true).snapshots,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          reverse: true,
          children: snapshot.data.documents.map((document){
            if(uid == document['uid']) {
              return new Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(document['sender'],
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        ),
                        new Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            child: document['imageUrl'] != null ?
                            new Image.network(
                              document['imageUrl'], width: 250.0,) :
                            new Text(document['text'])
                        ),
//                        new Text(document['timestamp'].toString()),
                      ],
                    ),
                    new Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0,),
                      child: document['senderImage'] != null ?
                      new CircleAvatar(
                        backgroundImage: new NetworkImage(
                            document['senderImage']),) :
                      new CircleAvatar(
                        child: new Text(document['sender'][0],),),
                    ),
                  ],
                ),
              );
            }else{
              return new Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: document['senderImage'] != null ?
                      new CircleAvatar(
                        backgroundImage: new NetworkImage(
                            document['senderImage']),) :
                      new CircleAvatar(
                        child: new Text(document['sender'][0],),),
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(document['sender'],
                          style: Theme
                              .of(context)
                              .textTheme
                              .subhead,
                        ),
                        new Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            child: document['imageUrl'] != null ?
                            new Image.network(
                              document['imageUrl'], width: 250.0,) :
                            new Text(document['text'])
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          }).toList(),
        );
      },
    );
  }
}