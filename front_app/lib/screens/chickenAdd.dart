
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front_app/screens/chickenAdd2.dart';

class chickenAdd extends StatefulWidget {
  @override
  State createState() => _ChickenAddPage();
}


class _ChickenAddPage extends State<chickenAdd> {

  final List<String> cateGoryList = [];
  List<DropdownMenuItem> dropList = [];
  List<DropdownMenuItem> secondDropList = [];


  @override
  void initState() {
    super.initState();
    this.getCategoryList();
    //데이터를 불러온다
  }


  Future<void> getCategoryList() async {

    List<DropdownMenuItem> dmiList = [];

    Firestore()
        .collection("category")
        .getDocuments().then((val){

            if(val.documents.length > 0){
              val.documents.forEach((element) {
                if(!cateGoryList.contains(element.data["소속"])){
                  dmiList.add(
                      new DropdownMenuItem(
                        child: Text(element.data["소속"]),
                          value: element.data["id"]
                      )
                  );
                  cateGoryList.add(element.data["소속"]);
                }
              });
            }
            else{
              print("Not Found");
            }
            this.getSecondCategoryList(1);
            this.setState(() {
              dropList = dmiList;
            });
    });
  }

  Future<void> getSecondCategoryList(int id) async {
    List<DropdownMenuItem> dmiList = [];
    Firestore()
        .collection("category")
        .where("id" ,isEqualTo: id)
        .getDocuments().then((val){

      if(val.documents.length > 0){
        val.documents.forEach((element) {
          dmiList.add(
                new DropdownMenuItem(
                    child: Text(element.data["이름"]),
                    value: element.data["sid"]
                )
            );
        });
      }
      else{
        print("Not Found");
      }
      this.setState(() {
        secondDropList = dmiList;
      });
    });
  }

  int _value = 1;
  int _sValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
            //Header
            DropdownButton(
                value: _value,
                items: dropList != null ? dropList : null
                ,
                onChanged: (value) {
                  print(value);
                  this.getSecondCategoryList(value);

                  setState(() {
                    _value = value;
                  });
                }),
              DropdownButton(
                  value: _sValue,
                  items: secondDropList != null ? secondDropList : null
                  ,
                  onChanged: (value) {
                    setState(() {
                      _sValue = value;
                    });
                  }),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RaisedButton(
                  color: Colors.indigo[300],
                  child: Text(
                    "등록하기",
                    style: TextStyle(color: Colors.white),
                  ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => chickenAdd2(val1: _value, val2: _sValue)),
                      );
                    }
                ),
              ),
          ],
          )
    )
    );
  }


}