import 'package:flutter/material.dart';

var theme= ThemeData(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.grey
        )
    ),
    iconTheme: IconThemeData(
        size: 30,
        color: Colors.black
    ),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(fontSize: 25)

    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
      elevation: 0,

    ),
    textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.red))
);