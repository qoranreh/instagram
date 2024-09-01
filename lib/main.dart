import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

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
var likes=[];
var user =[];
var content =[];
class _MyAppState extends State<MyApp> {

  getData()async{
    var result = await http.get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    //링크 변수에 넣어쓰기
    var result2=jsonDecode(result.body);
    print(result2[0]);
    for(int i=0;i<3;i++)
      {
        likes.add(result2[i]['likes']);
        content.add(result2[i]['content']);
        user.add(result2[i]['user']);
      }
    print(likes);
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
      body: [homeMain(likes:likes, content: content,user:user),Text('샵페이지')][tap]
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
class homeMain extends StatelessWidget {
   homeMain({super.key,this.likes,this.content,this.user});
  var likes;
  var content;
  var user;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (c,i){
        imagesNum=i;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
                children: [
                  Container(
                      child:
                      Image.asset(images[imagesNum])
                  )
                  ,
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(likes[i].toString()),
                        Text(user[i]),
                        Text(content[i])],
                    ),
                  )
                ]),
          ),
        );
      },);
  }
}

