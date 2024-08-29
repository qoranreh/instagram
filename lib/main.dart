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
//변수 넣는 곳
var tap =0;
var images = ['assets/images.jpeg','assets/images (1).jpeg','assets/Instagram1.jpeg'];
var imagesNum=0;
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined,))],
      ),
      body: [homeMain(),Text('샵페이지')][tap]
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
  const homeMain({super.key});

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
                        Text('좋아요 100'),
                        Text('글쓴이'),
                        Text('글내용')],
                    ),
                  )
                ]),
          ),
        );
      },);
  }
}

