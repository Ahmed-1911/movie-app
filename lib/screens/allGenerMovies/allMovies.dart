import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie/screens/details_page/details.dart';
import 'package:movie/screens/details_page/person-details.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllMovies extends StatefulWidget {
  AllMovies(@required this.url, @required this.url2,
      [@required this.type = 'movie']);
  String url;
  String url2;
  String type;
  @override
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  List listItems = [];
  fetchAllItems() async {
    try {
      var url = '${widget.url}';
      var url2 = '${widget.url2}';
      final response = await http.get(url);
      final response2 = await http.get(url2);
      final extractedData = json.decode(response.body);
      final extractedData2 = json.decode(response2.body);
      if (response.statusCode == 200) {
        setState(() {
          widget.type == 'geners'
              ? listItems.addAll(extractedData['genres'])
              : listItems.addAll(extractedData['results']);
          listItems.addAll(extractedData2['results']);
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  @override
  void initState() {
    fetchAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(
            listItems.length == 0 ? 30 : listItems.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 1500),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                      child: listItems.length == 0
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
                                          spreadRadius: 1)
                                    ]),
                              ),
                              shimmerColor: Colors.white,
                            )
                          : GestureDetector(
                            onTap: (){
                              widget.type=='movie'?
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(listItems[index]['id']))):
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(listItems[index]['id'])));
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
                                        'https://image.tmdb.org/t/p/w500/${widget.type == 'movie' ? listItems[index]['poster_path'] : listItems[index]['profile_path']}'),
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500/${widget.type == 'movie' ? listItems[index]['poster_path'] : listItems[index]['profile_path']}'),
                                    fadeDuration: Duration(seconds: 2),
                                    excludeFromSemantics: true,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                          )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
