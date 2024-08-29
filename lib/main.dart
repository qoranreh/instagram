import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;

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
var tap =0;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined,))],
      ),
      body:ListView.builder(
        itemCount: 3,
        itemBuilder: (c,i){
          return Pead();
      },)
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
class Pead extends StatelessWidget {
  const Pead ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset('assets/images.jpeg'),
      Text('좋아요 100'),
      Text('글쓴이'),
      Text('글내용'),
]);
  }
}
