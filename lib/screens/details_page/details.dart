import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/constraines.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progressive_image/progressive_image.dart';
import 'package:skeleton_text/skeleton_text.dart';
class Details extends StatefulWidget {
  Details(@required this.movieID );
  int movieID;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  var movieDetails;
  List similarMovies;
  fetchDetails() async {
    try {
      var url = 'https://api.themoviedb.org/3/movie/${widget.movieID}?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
           movieDetails=extractedData;
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  fetchSimilar() async {
    try {
      var url = 'https://api.themoviedb.org/3/movie/${widget.movieID}/similar?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&page=1';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
           similarMovies=extractedData['results'];
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  @override
  void initState() {
    fetchDetails();
   fetchSimilar();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               //Top Container
              Hero(
                tag: 'back',
                child: Container(
                  height: size.height*0.4,
                  child: Stack(
                    children: <Widget>[
                      movieDetails==null?
                      SkeletonAnimation(
                        child: Container(
                          height: size.height* 0.4 - 50,
                          margin: EdgeInsets.all(5),
                          //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                             ),
                        ),
                        shimmerColor: Colors.white,
                      ) : Container (
                        height: size.height* 0.4 - 50,
                        child:ProgressiveImage(
                          placeholder:AssetImage('assets/images/loading.gif'),
                          thumbnail: NetworkImage('https://image.tmdb.org/t/p/w500/${movieDetails['backdrop_path']}'),
                          image: NetworkImage('https://image.tmdb.org/t/p/w500/${movieDetails['backdrop_path']}'),
                          fadeDuration: Duration(seconds: 2),
                          excludeFromSemantics: true,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),),
//                          image: DecorationImage(
//                              image: AssetImage(movieDetails['sf']),
//                              fit: BoxFit.fill
//                          )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: movieDetails==null?
                        SkeletonAnimation(
                          child: Container(
                            height: 100,
                            width: size.width*0.9,
                            margin: EdgeInsets.all(5),
                            //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset:Offset(0,5),
                                    blurRadius: 50,
                                    color: Color(0xFF12153D0).withOpacity(0.2)
                                )
                              ],
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),topLeft: Radius.circular(50)),
                            ),
                          ),
                          shimmerColor: Colors.white,
                        ) :Container (
                          height: 100,
                          width: size.width*0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset:Offset(0,5),
                                  blurRadius: 50,
                                  color: Color(0xFF12153D0).withOpacity(0.2)
                                )
                              ],
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),topLeft: Radius.circular(50)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color:Colors.amber,
                                    size: 35,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: '${movieDetails['vote_average']}/10',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ],
                                    )
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.star_border,
                                    color:Colors.grey,
                                    size: 35,
                                  ),
                                  RichText(
                                      text: TextSpan(
                                        style: TextStyle(color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: 'Rate This',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    padding:EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(
                                        '${movieDetails['vote_count']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Metascore',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //title and button
              Padding(
                padding: const EdgeInsets.all(KDefaultPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          movieDetails==null?
                          SkeletonAnimation(
                            child: Container(
                              height: 50,
                              width: 300,
                              margin: EdgeInsets.all(5),
                              //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                            ),
                            shimmerColor: Colors.white,
                          ) :Text(
                            movieDetails['title'],
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(height: 5),
                          movieDetails==null?
                          SkeletonAnimation(
                            child: Container(
                              height: 70,
                              width: 300,
                              margin: EdgeInsets.all(5),
                              //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                            ),
                            shimmerColor: Colors.white,
                          ) : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                movieDetails['status'],
                                style: TextStyle(
                                  color:Colors.grey,
                                  fontSize: 16
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                ' PG-13',
                                style: TextStyle(
                                    color:Colors.grey,
                                    fontSize: 16
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                '${movieDetails['runtime']%60}h ${movieDetails['runtime']%60}m',
                                style: TextStyle(
                                    color:Colors.grey,
                                    fontSize: 16
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    movieDetails==null?
                    SkeletonAnimation(
                      child: Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.all(5),
                        //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                      ),
                      shimmerColor: Colors.white,
                    ) : SizedBox(
                      width: 60,
                      height: 60,
                      child: FlatButton(
                        color: KSecColor,
                        onPressed: (){

                        },
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(15)
                         ),
                        child: Icon(Icons.add,color: Colors.white,size: 30,),
                      ),
                    )
                  ],
                ),
              ),
              //genars
              Container(
                width: size.width,
                height:40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:movieDetails==null?5:movieDetails['genres'].length ,
                  itemBuilder: (context,index){
                    return movieDetails==null?
                    SkeletonAnimation(
                      child: Container(
                        height: 50,
                        width: 100,
                        margin: EdgeInsets.all(5),
                        //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                        ),
                      ),
                      shimmerColor: Colors.white,
                    ) : Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: KDefaultPadding),
                      padding: EdgeInsets.symmetric(
                          vertical: KDefaultPadding/4,
                          horizontal: KDefaultPadding
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black26
                          ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(
                        movieDetails['genres'][index]['name'],
                        style: TextStyle(
                          color: KTextColor.withOpacity(0.8,),
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
              //plot
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: KDefaultPadding/2,
                  horizontal: KDefaultPadding
                ),
                child: movieDetails==null?
                SkeletonAnimation(
                  child: Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  shimmerColor: Colors.white,
                ) : Text(
                  'Plot Summery',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              //plot body
              Padding(
                padding: EdgeInsets.symmetric(

                horizontal: KDefaultPadding
                 ),
                child: movieDetails==null?
                SkeletonAnimation(
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(5),
                    //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  shimmerColor: Colors.white,
                ) :Text(
                  movieDetails['overview'],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
              //similar Movies
              Padding(
                padding: const EdgeInsets.symmetric(
                vertical: KDefaultPadding/2,
                horizontal: KDefaultPadding,
               ),
                child:movieDetails==null?
                SkeletonAnimation(
                  child: Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  shimmerColor: Colors.white,
                ) :Text(
                'Similar Movies',
                style: Theme.of(context).textTheme.headline5,
              ),
              ),
             //list cast
              Container(
                height: MediaQuery.of(context).size.height*0.2,
                padding: EdgeInsets.only(bottom: 5),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 120,
                  itemCount: similarMovies==null||similarMovies.length==0?7:similarMovies.length,
                  itemBuilder: (context,index) {
                    return similarMovies == null||similarMovies.length==0
                        ? SkeletonAnimation(
                        child: Container(
                        margin: EdgeInsets.all(5),
                        //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(4, 0),
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  spreadRadius: 1
                              )
                            ]),
                      ),
                      shimmerColor: Colors.white,
                    )
                        : GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context)=>Details(similarMovies[index]['id'])
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(4, 0),
                                    color: Colors.black26,
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ProgressiveImage(
                                placeholder:
                                AssetImage('assets/images/loading.gif'),
                                thumbnail: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${similarMovies[index]['poster_path']}'),
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${similarMovies[index]['poster_path']}'),
                                fadeDuration: Duration(seconds: 2),
                                excludeFromSemantics: true,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
