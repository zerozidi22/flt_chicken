

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_provider.dart';

class myPage extends StatefulWidget {
  @override
  State createState() => _MyPage();
}


class _MyPage extends State<myPage> {
  FirebaseProvider fp;
  String uid = "";

  test(){
    Firestore()
        .collection("users")
        .document("2tSqreCOVxScBxQpCnlSPAAUS9t2")
        .get().then((DocumentSnapshot ds) {
      print(ds.data['NICK_NAME']);
      uid = ds.data['NICK_NAME'];
    });
  }


  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    test();
    return Container(
      child: Text(uid),
    );
  }

}

