import 'package:flutter/material.dart';//기본
import 'package:cloud_firestore/cloud_firestore.dart';//파이어베이스 사용하면 

final firestore= FirebaseFirestore.instance;//firestore에서 유용한 함수 불러올수 있음.

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData(){
    var result = firestore.collection('product').doc('JnbqaLZUSowL6M0jANwl').get();
    print(result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('샵페이지임'),
    );
  }
}


