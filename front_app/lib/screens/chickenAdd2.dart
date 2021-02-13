import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

import 'firebase_provider.dart';

class chickenAdd2 extends StatefulWidget {

  final int val1;
  final int val2;

  chickenAdd2({Key key, this.val1, this.val2 }) : super(key: key);

  @override
  State createState() => _ChickenAddPage2();
}


class _ChickenAddPage2 extends State<chickenAdd2> {
  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";
  String brand = "";
  String ckName = "";
  TextEditingController _Con = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.getData(widget.val1, widget.val2);
    _prepareService();

  }

  Future<void> getData(int id, int sid) async {
    print("hi");
    print(id);
    print(sid);

    Firestore()
        .collection("category")
        .where("id" ,isEqualTo: id)
        .where("sid", isEqualTo: sid)
        .getDocuments().then((val){

      if(val.documents.length > 0){
        this.setState(() {
          brand = val.documents[0].data['소속'];
          ckName = val.documents[0].data['이름'];
        });
      }
      else{
        print("Not Found");
      }

    });
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_image.toString())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 업로드할 이미지를 출력할 CircleAvatar
            CircleAvatar(
              backgroundImage:
              (_image != null) ? FileImage(_image) : NetworkImage(""),
              radius: 30,
            ),
            // 업로드할 이미지를 선택할 이미지 피커 호출 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(brand),
                  onPressed: () {
                    _uploadImageToStorage(ImageSource.gallery);
                  },
                ),
                RaisedButton(
                  child: Text(ckName),
                  onPressed: () {
                    _uploadImageToStorage(ImageSource.camera);
                  },
                )
              ],
            ),
            TextField(
                controller: _Con,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.wysiwyg_rounded),
                  hintText: "내용",
                )
            ),
            RaisedButton(
              child: Text("등록"),
              onPressed: () {
                _uploadToFireBaseAndDB();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
    });

  }

  void _uploadToFireBaseAndDB() async {

    String uuid = Uuid().v1();
    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    StorageReference storageReference = _firebaseStorage.ref().child("ck/${uuid}/${_user.uid}");

    // 파일 업로드
    StorageUploadTask storageUploadTask = storageReference.putFile(_image);

    // 파일 업로드 완료까지 대기
    await storageUploadTask.onComplete;

    // 업로드한 사진의 URL 획득
    String downloadURL = await storageReference.getDownloadURL();
print("----------------------------------------------------------------------------");
    print(_user.uid);


    //db에 insert
   await Firestore()
        .collection("contents")
        .document(uuid)
        .setData(
        {
          "imgUrl" : downloadURL,
          "user" : _user.uid,
          "contents" : _Con.text,
          "dateTime" : DateTime.now(),
          "brand" : brand,
          "ckName" : ckName
        }).then((_) {
      print("success!");
    });

    // 업로드된 사진의 URL을 페이지에 반영
    setState(() {
      _profileImageURL = downloadURL;
    });

  }


}

