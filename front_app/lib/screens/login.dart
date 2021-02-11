

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_page.dart';
import 'firebase_provider.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseProvider>(
            builder: (_) => FirebaseProvider())
      ],
      child: MaterialApp(
        title: "Flutter Firebase",
        home: AuthPage(),
      ),
    );
  }
}
