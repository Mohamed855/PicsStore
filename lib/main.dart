// import packages

import 'package:flutter/material.dart';
import 'package:PicsStore/content.dart';
import 'package:PicsStore/home.dart';

main() => runApp(_App()); // main run app

// app class

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false, // hide debug mode banner
        title: 'Pics Store',
        theme: ThemeData(
          primaryColor: themeColor,
          accentColor: themeColor,
          backgroundColor: Colors.white54,
          cardColor: Colors.white,
          shadowColor: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        home: Home(), // home page
        routes: {},
      );
}
