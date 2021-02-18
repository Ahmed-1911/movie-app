import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/componants/widgets.dart';
import 'package:movie/constraines.dart';
import 'package:movie/screens/test.dart';
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey2=GlobalKey<FormState>();
  var loading=false;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //form
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.only(top: 15,left: 15,right: 15),
                  height: getHeight(context)*0.35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1,1),
                        color: primColor,
                        blurRadius:5,
                        spreadRadius: 1
                      )
                    ]
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //User Name
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                height: getHeight(context)*0.08 ,
                                child:icontextField(userName, "Enter User Name", UserNameValidate,Icons.person,false)
                            ),
                          ),
                          //Password
                          Flexible(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                height: getHeight(context)*0.08 ,
                                child:icontextField(password, "Enter Password", passValidate,Icons.lock,true)
                            ),
                          ),
                          //Text
                          Flexible(
                            child: Container(
                              height: getHeight(context)*0.1 ,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context)=>Test()
                                      )
                                      );
                                    },
                                    child: autoText('You Need Account ?', 1, 18 ,Colors.black)
                                  ),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: autoText('Register', 1, 18 ,primColor)
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context)*0.05,
                          )
                        ],
                      ),
                      Positioned(
                        bottom: -getHeight(context)*0.025,
                        child://logIn button
                        GestureDetector(
                          onTap: ()async{
                            if (_formKey2.currentState.validate()){
                              _formKey2.currentState.save();
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context)=>Test()
                              )
                              );
                              userName.clear();
                              password.clear();
                            }
                          },
                          child: saveButton(context,'Log IN'),
                        ) ,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
