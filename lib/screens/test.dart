import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/componants/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie/constraines.dart';
import 'package:movie/screens/shoe.dart';

class Test extends StatefulWidget {
  @override
  _AllGenersState createState() => _AllGenersState();
}

class _AllGenersState extends State<Test> {
  fetchData() async {
    try {
      var url = 'https://jsonplaceholder.typicode.com/posts';
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        return extractedData;
      }
      else{
        return [];
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('All Articles', style: GoogleFonts.elMessiri(fontSize: 20)),
          backgroundColor: Colors.teal,
        ),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
            return !snapshot.hasData
                ? Center(child: autoText('Connection Error', 1, 20)):
                snapshot.connectionState == ConnectionState.waiting?
                spinKit(context):
                 AnimationLimiter(
                    child: ListView.builder(
                      itemBuilder: (BuildContext ctx, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 2000),
                          child: SlideAnimation(
                            horizontalOffset: index % 2 == 0 ? 150 : -150.0,
                            verticalOffset:   index % 2 == 0 ? 75  : -75.0,
                            child: FadeInAnimation(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context)=>Show(snapshot.data[index])
                                  )
                                  );
                                },
                                child: Hero(
                                  tag: snapshot.data[index]['id'],
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(ctx).size.height * 0.1,
                                    child: autoText(snapshot.data[index]['title'], 2, 18),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.teal, width: 1.5),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.cyan[200],
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: Offset(2, 2))
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ));
  }
}
