import 'package:flutter/material.dart';
import 'package:movie/componants/widgets.dart';
import '../../constraines.dart';
import '../../models/movie.dart';
import 'package:movie/screens/details_page/details.dart';
import 'dart:math'as math;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Swaper(),
              //Kind(),
              GenerSection('Popular',"https://api.themoviedb.org/3/movie/popular?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1"),
              GenerSection('Top Rated',"https://api.themoviedb.org/3/movie/top_rated?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1"),
              GenerSection('Upcoming',"https://api.themoviedb.org/3/movie/upcoming?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1"),
              GenerSection('War','https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=10752'),
              GenerSection('Trending',"https://api.themoviedb.org/3/trending/movie/week?api_key=5748c9cc927b2d946e4d0c007bb63972"),
              GenerSection('Animation','https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=16'),
              GenerSection('Action','https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28'),
              GenerSection('Science Fiction','https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=878'),
              GenerSection('People ','https://api.themoviedb.org/3/person/popular?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1','person'),
            ],
          ),
        ) ,
      ),
    );
  }
}