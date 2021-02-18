import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie/screens/details_page/details.dart';
import 'package:progressive_image/progressive_image.dart';
import 'dart:convert';

import 'package:skeleton_text/skeleton_text.dart';
class Profile extends StatefulWidget {
  Profile(@required this.personID);
  var personID;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var personDetails;
  List moviesList=[];
  fetchDetails() async {
    try {
      var url = 'https://api.themoviedb.org/3/person/${widget.personID}?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          personDetails=extractedData;
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  fetchMovies() async {
    try {
      var url = 'https://api.themoviedb.org/3/discover/movie?api_key=5748c9cc927b2d946e4d0c007bb63972&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_people=${widget.personID}';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          moviesList=extractedData['results'];
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
    fetchMovies();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double widthC = MediaQuery.of(context).size.width * 100;
    return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //==========================================================================================
              // build Top Section of Profile (include : Profile Image)
              //==========================================================================================
              _buildHeader(),

              //==========================================================================================
              // build middle Section of Profile (include : main info  )
              //==========================================================================================
              _buildMainInfo(context,widthC),


              SizedBox(height: 10.0),


              //==========================================================================================
              //  build Bottom Section of Profile (include : email - phone number - about - location )
              //==========================================================================================
              _buildInfo(context,widthC),

              Container(
                height: MediaQuery.of(context).size.height*0.25,
                padding: EdgeInsets.only(bottom: 5),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 120,
                  itemCount: moviesList==null||moviesList.length==0?7:moviesList.length,
                  itemBuilder: (context,index) {
                    return moviesList == null||moviesList.length==0
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
                                builder: (context)=>Details(moviesList[index]['id'])
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
                                'https://image.tmdb.org/t/p/w500/${moviesList[index]['poster_path']}'),
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500/${moviesList[index]['poster_path']}'),
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
        ));
  }

  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            gradient: LinearGradient(colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ]),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 120),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.white,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.lightBlueAccent,
                      Colors.lightBlue,
                    ]),
                  ),
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular( 85),
                        child:personDetails==null?
                        SkeletonAnimation(
                          child: Container(
                            width: 120,
                            height: 120,
                            margin: EdgeInsets.all(5),
                            //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                ),
                          ),
                          shimmerColor: Colors.white,
                        ):
                        Image.network('https://image.tmdb.org/t/p/w500/${personDetails['profile_path']}',width: 120,height: 120,fit: BoxFit.fill)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMainInfo(BuildContext context,double width){
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      child: Column(
        children: <Widget>[
          personDetails==null?
          SkeletonAnimation(
            child: Container(
              width: 120,
              height: 40,
              margin: EdgeInsets.all(5),
              //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            shimmerColor: Colors.white,
          ):
          Text(personDetails['name'],style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          personDetails==null?
          SkeletonAnimation(
            child: Container(
              width: 80,
              height: 40,
              margin: EdgeInsets.all(5),
              //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
            ),
            shimmerColor: Colors.white,
          ):
          Text(personDetails['known_for_department'],style: TextStyle(color: Colors.blue))
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context,double width){
    return Container(
        padding: EdgeInsets.all(10),
        child:   Card(
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[


                    ListTile(
                      leading: Icon(Icons.date_range,color: Colors.blue),
                      title: Text("Birthday"),
                      subtitle: personDetails==null?
                      SkeletonAnimation(
                        child: Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                        ),
                        shimmerColor: Colors.white,
                      ):Text(personDetails['birthday']),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.my_location,color: Colors.blue),
                     title: Text("Place of Birth"),
                      subtitle: personDetails==null?
                      SkeletonAnimation(
                        child: Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                        ),
                        shimmerColor: Colors.white,
                      ):Text(personDetails['place_of_birth']),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.stars,color: Colors.blue),
                      title: Text("Popularity"),
                      subtitle: personDetails==null?
                      SkeletonAnimation(
                        child: Container(
                          width: 80,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                        ),
                        shimmerColor: Colors.white,
                      ):Text(personDetails['popularity'].toString()),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}
