import 'package:flutter/material.dart';
import 'package:front_app/screens/chickenAdd.dart';
import 'package:front_app/screens/chickenRank.dart';
import 'package:front_app/screens/login.dart';
import 'package:front_app/screens/memberRank.dart';
import 'package:front_app/screens/myPage.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = '4d5f60426000aaf1728a60ad3f7b8e74';
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  int _currentIndex = 0;

  final List<Widget> _children = [chickenRank(), memberRank(), chickenAdd(), myPage(), login()];

  void _onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: _children,
          physics: NeverScrollableScrollPhysics(), // No sliding
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onTap,
            currentIndex: _currentIndex,
            items: [
              new BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                title: Text('치킨랭킹'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered),
                title: Text('칰커랭킹'),
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('치킨등록'),
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('마이')
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.login),
                  title: Text('로그인')
              )
            ]
        )
    );
  }
}
