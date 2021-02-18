import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie/componants/widgets.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screens/Home/home.dart';
import 'package:movie/screens/allGenerMovies/allMovies.dart';
import 'package:skeleton_text/skeleton_text.dart';
class AllMovieGen extends StatefulWidget {
  @override
  _AllGenersState createState() => _AllGenersState();
}

class _AllGenersState extends State<AllMovieGen> {
  List genList = [];
  fetchAllGen() async {
    try {
      var url = 'https://api.themoviedb.org/3/genre/movie/list?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
           genList=extractedData['genres'];
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    fetchAllGen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: genList.length==0?10:genList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1500),
              child: SlideAnimation(
                horizontalOffset: index%2 == 0? 150 : -150.0,
                verticalOffset: index%2 == 0? 75 : -75.0,
                child: FadeInAnimation(
                  child: genList.length==0?
                  SkeletonAnimation(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height*0.15,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.cyan,
                              width: 1.5
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.cyan[200],
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(2,2)
                            )
                          ]
                      ),
                    ),
                    shimmerColor: Colors.white,
                  ):
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>AllMovies('https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=${genList[index]['id']}'
                                                           ,'https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=2&with_genres=${genList[index]['id']}')
                          )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height*0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          autoText(genList[index]['name'], 1, 22,Colors.black87)
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.cyan,
                              width: 1.5
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.cyan[200],
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(2,2)
                            )
                          ]
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}