import 'package:flutter/material.dart';

var theme= ThemeData(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.grey
        )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0)


      )
    ),
    iconTheme: IconThemeData(
        size: 30,
        color: Colors.black
    ),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.1,
        titleTextStyle: TextStyle(fontSize: 25,color: Colors.black)

    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
      elevation: 0,

    ),
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.red))
);