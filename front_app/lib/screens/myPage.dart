

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_provider.dart';

class myPage extends StatefulWidget {
  @override
  State createState() => _MyPage();
}


class _MyPage extends State<myPage> {
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Container(
      child: Text(fp.getUser().uid),
    );
  }

}