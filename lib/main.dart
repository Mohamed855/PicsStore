import 'package:flutter/material.dart';
import 'package:picsStore/content.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'models/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pics Store',
        theme: ThemeData(
          primaryColor: themeColor,
          accentColor: themeColor,
          canvasColor: Color.fromRGBO(245, 245, 245, 1.0),
          cardColor: Colors.white,
          shadowColor: Color.fromRGBO(0, 0, 0, 0.7),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
            headline2: TextStyle(
              fontSize: 22.0,
              color: themeColor,
              letterSpacing: 2.0,
            ),
            headline3: TextStyle(
              fontSize: 18.0,
              color: Colors.black87,
              letterSpacing: 2.0,
            ),
            bodyText1: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 18.0,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              letterSpacing: 1.0,
              fontSize: 18.0,
            ),
          ),
        ),
        home: LoginScreen(),
        routes: {
          '/signup': (ctx) => SignupScreen(),
          '/login': (ctx) => LoginScreen(),
          '/home': (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
