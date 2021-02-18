import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie/componants/widgets.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screens/Home/home.dart';
import 'package:movie/screens/allGenerMovies/allMovieGen.dart';
import 'package:movie/screens/allGenerMovies/allMovies.dart';
class AllGeners extends StatefulWidget {
  @override
  _AllGenersState createState() => _AllGenersState();
}

class _AllGenersState extends State<AllGeners> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: sectionList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1500),
              child: SlideAnimation(
                horizontalOffset:150 ,
                verticalOffset: 75,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: (){
                      index==0?Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>AllMovieGen()
                          )
                      ):
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>AllMovies(
                                  sectionList[index].api1,
                                  sectionList[index].api2,
                                  sectionList[index].title=='All Geners'?'geners'
                                      :
                                  sectionList[index].title=='Popular People'?
                                  'people'
                                      :
                                  'movie')
                          )
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height*0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(sectionList[index].icon,size: 30,color: Colors.cyan,),
                          SizedBox(width: 30,),
                          autoText(sectionList[index].title, 1, 22,Colors.black87)
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