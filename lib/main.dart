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


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined,))],
      ),
      body: Container(child: Text('글자 '),),
      bottomNavigationBar: BottomAppBar( child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.home_outlined)),
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined))
      ],),)
    );

  }
}
