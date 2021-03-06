import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class chickenRank extends StatefulWidget {
  @override
  State createState() => _chickenRankPage();
}

final List<String> imgList = [
  'http://reasley.com/wp-content/uploads/2020/04/one.jpg',
  'http://reasley.com/wp-content/uploads/2020/04/two.jpg',
  'http://reasley.com/wp-content/uploads/2020/04/three.jpg'
];


final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'No. ${imgList.indexOf(item)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();


class _chickenRankPage extends State<chickenRank> {
  int _current = 0;
  int _currentIndex = 0;
  goSecondPage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => second(url: this.editController.text
    //   )),
    // );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
        SafeArea(
        child: Column(
          children: <Widget>[
              CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: imgList.map((url) {
              //     int index = imgList.indexOf(url);
              //     return Container(
              //       width: 5.0,
              //       height: 5.0,
              //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: _current == index
              //             ? Color.fromRGBO(0, 0, 0, 0.9)
              //             : Color.fromRGBO(0, 0, 0, 0.4),
              //       ),
              //     );
              //   }).toList(),
              // ),
            Container(
                child: TextField(
                    // controller: editController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Hint',
                    )
                )
            ),
            RaisedButton(onPressed: () { this.goSecondPage(); }, child: Text('검색하기')),
          ],
        ),
      ),
    );
  }


}