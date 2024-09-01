import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: style.theme,
         home: MyApp()
  )
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


//변수 넣는 곳
var tap =0;
var images = ['assets/images.jpeg','assets/images (1).jpeg','assets/Instagram1.jpeg'];
var imagesNum=0;
var data=[];
class _MyAppState extends State<MyApp> {

  getData()async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    //링크 변수에 넣어쓰기
    var result2=jsonDecode(result.body);
    setState(() {
      data=result2;
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined,))],
      ),
      body: [homeMain(data:data,images:images),Text('샵페이지')][tap]
      ,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i){
          setState(() {
            tap=i;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: '쇼핑')
      ],)
    );

  }
}
class homeMain extends StatefulWidget {
   homeMain({super.key,this.data,this.images});
  final data;
  final images;

  @override
  State<homeMain> createState() => _homeMainState();
}
class _homeMainState extends State<homeMain> {
  var scroll= ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener((){
        print(scroll.position.pixels);
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 3, controller:scroll,itemBuilder: (c,i){
        if(widget.data.isNotEmpty){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                  children: [
                    Container(
                        child:
                        Image.network(widget.data[i]['image'])
                    )
                    ,
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('좋아요 ${widget.data[i]['likes'].toString()}'),
                          Text(widget.data[i]['user']??''),
                          Text(widget.data[i]['content']??'')
                        ],
                      ),
                    )
                  ]),
            ),
          );
        }
        else{
          Text('로딩중');
        }
      },);
  }
}

