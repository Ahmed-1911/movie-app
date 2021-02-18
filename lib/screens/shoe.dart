import 'package:flutter/material.dart';
import 'package:movie/componants/widgets.dart';
class Show extends StatelessWidget {
  Show(this.post);
  var post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: post['id'],
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child:autoText(post['title'], 2, 21,Colors.white),
                decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent[100],
                    borderRadius: BorderRadius.circular(40)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: autoText(post['body'], 8 , 20 ,Colors.white),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(40)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
