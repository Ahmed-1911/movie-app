import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screens/splash.dart';
import 'package:movie/screens/test-login.dart';
import 'package:movie/screens/test.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider<Movies>(create: (_) => Movies(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LogIn(),
    );
  }
}
