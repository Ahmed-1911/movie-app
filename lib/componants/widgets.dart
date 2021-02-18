import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/screens/details_page/details.dart';
import 'package:movie/screens/geners/geners.dart';
import 'package:progressive_image/progressive_image.dart';
import '../constraines.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../screens/details_page/person-details.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
      onPressed: () {},
      padding: EdgeInsets.only(left: KDefaultPadding),
      icon: Icon(
        Icons.menu,
        color: Colors.black,
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search, color: Colors.black),
        onPressed: () {},
      )
    ],
  );
}
//**************************************************************************************
class Kind extends StatefulWidget {
  @override
  _KindState createState() => _KindState();
}

class _KindState extends State<Kind> {
  List Kinds = [];
  fetchAllKinds() async {
    try {
      var url =
          'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&language=en-US';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          Kinds = extractedData['genres'];
        });
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    fetchAllKinds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: KDefaultPadding / 2),
      height: 35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Kinds.length == 0 ? 5 : Kinds.length,
          itemBuilder: (context, index) => KindCard(
                title: Kinds.length == 0 ? '' : Kinds[index]['name'],
              )),
    );
  }
}

class KindCard extends StatelessWidget {
  String title;
  KindCard({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: KDefaultPadding),
      padding: EdgeInsets.symmetric(
          vertical: KDefaultPadding / 4, horizontal: KDefaultPadding),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        title,
        style: TextStyle(
          color: KTextColor.withOpacity(
            0.8,
          ),
          fontSize: 16,
        ),
      ),
    );
  }
}

//***********************************************************************************
class Swaper extends StatefulWidget {
  @override
  _SwaperState createState() => _SwaperState();
}

class _SwaperState extends State<Swaper> {
  List swaperItems = [];
  fetchAllItems() async {
    try {
      var url =
          'https://api.themoviedb.org/3/trending/movie/day?api_key=5748c9cc927b2d946e4d0c007bb63972';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          swaperItems = extractedData['results'];
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return swaperItems.length == 0
              ? SkeletonAnimation(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    width: MediaQuery.of(context).size.width*0.84 ,
                    color: Colors.grey[300],
                  ),
                  shimmerColor: Colors.white,
                )
              : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ProgressiveImage(
                    placeholder: AssetImage('assets/images/loading.gif'),
                    thumbnail: NetworkImage('https://image.tmdb.org/t/p/w500/${swaperItems[index]['backdrop_path']}'),
                    image:NetworkImage('https://image.tmdb.org/t/p/w500/${swaperItems[index]['backdrop_path']}'),
                    fadeDuration: Duration(seconds: 2),
                    excludeFromSemantics: true,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width*0.84,
                    fit: BoxFit.fill,
                  ),
                ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.84 ,
                    alignment: Alignment.bottomCenter,
                    child: autoText(swaperItems[index]['title'], 1, 20,
                        Colors.white),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment(1, 1),
                            end: Alignment(1, 0.2),
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                            ]
                        )
                    ),
                  )
                ]);
        },
        itemCount: swaperItems.length == 0 ? 1 : swaperItems.length,
        scrollDirection: Axis.horizontal,
        itemWidth: MediaQuery.of(context).size.width ,
        itemHeight: MediaQuery.of(context).size.height * 0.22,
        layout: SwiperLayout.STACK,
        autoplay: swaperItems.length == 0?false:true,
        loop: true,
        autoplayDisableOnInteraction: true,
        scale: 0.7,
        viewportFraction: 0.8,
        fade: 5,
      ),
    );
  }
}

//***********************************************************************************************
AutoSizeText autoText(String text, int maxLine, double fontSize,
    [Color color = Colors.black,String type = 'title']) {
  return AutoSizeText(text,
      maxLines: maxLine,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      style: type != 'head'
          ? GoogleFonts.elMessiri(
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
              color: color,
            )
          :
            GoogleFonts.elMessiri(
              fontWeight: FontWeight.w800,
              fontSize: fontSize,
              color: color,
            )
  );
}
//******************************************************************************************************

class GenerSection extends StatefulWidget {
  GenerSection(@required this.text,@required this.url,[@required this.type='movie']);
  String text;
  String url;
  String type;
  @override
  _generSectionState createState() => _generSectionState();
}

class _generSectionState extends State<GenerSection> {

  List listItems = [];
  fetchAllItems() async {
    try {
      var url = '${widget.url}';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          listItems = extractedData['results'];
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
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: KDefaultPadding/2,
                horizontal: KDefaultPadding,
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  autoText(widget.text, 1, 22 , Colors.black,'head'),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllGeners()));
                      },
                      child: Icon(Icons.more_vert))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemExtent: 120,
                itemCount: listItems.length == 0 ? 7 : listItems.length,
                itemBuilder: (context,index) {
                  return listItems.length == 0 ?
                  SkeletonAnimation(
                     child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      //padding: EdgeInsets.symmetric( horizontal: KDefaultPadding),
                       decoration: BoxDecoration(
                         color: Colors.grey[200],
                         boxShadow: [
                           BoxShadow(
                               offset: Offset(4,0),
                               color: Colors.black26,
                               blurRadius: 1,
                               spreadRadius: 1
                           )
                         ]
                       ),
                    ),
                    shimmerColor: Colors.white,
                  )
                      :
                  GestureDetector(
                    onTap: (){
                      widget.type=='movie'?
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(listItems[index]['id']))):
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(listItems[index]['id'])));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4,0),
                              color: Colors.black26,
                              blurRadius: 1,
                              spreadRadius: 1
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ProgressiveImage(
                        placeholder: AssetImage('assets/images/loading.gif'),
                        thumbnail: NetworkImage('https://image.tmdb.org/t/p/w500/${widget.type=='movie'?listItems[index]['poster_path']:listItems[index]['profile_path']}'),
                        image:NetworkImage('https://image.tmdb.org/t/p/w500/${widget.type=='movie'?listItems[index]['poster_path']:listItems[index]['profile_path']}'),
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
            ),
          ),
        ],
      ),
    );
  }
}
