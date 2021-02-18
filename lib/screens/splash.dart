import 'dart:async';
import 'package:flutter/material.dart';

import 'Home/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>  with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  void initState() {
    super.initState();
    _animationController=AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
      });
    });
    Timer(Duration(seconds: 7),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.gif'),
              fit: BoxFit.fill
            )
          ),
        )
      ),
    );
  }
}
