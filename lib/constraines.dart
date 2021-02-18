import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'componants/widgets.dart';
const apiKey='5748c9cc927b2d946e4d0c007bb63972';
const KSecColor=Color(0xFFFE6D8E);
const KTextColor=Color(0xFF12153D);
const KTextLightColor=Color(0xFF9A9BB2);
const KFillStarColor=Colors.amber;
const primColor=Colors.teal;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
TextFormField icontextField(TextEditingController controller, String label,
    Function valid, IconData icon, bool scure) {
  return TextFormField(
    validator: valid,
    controller: controller,
    cursorColor: Colors.black,
    obscureText: scure,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      suffixIcon: Icon(
        icon,
        size: 25,
        color: Colors.black,
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(15)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15)),
    ),
    onSaved: (String val) {
      controller.text = val.trim();
    },
  );
}
Container saveButton(BuildContext context, String text,) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.4,
    height: MediaQuery.of(context).size.height * 0.06,
    child:autoText(text, 1, 17,Colors.white),
    decoration: BoxDecoration(
      color: primColor,
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
SpinKitWave spinKit(BuildContext context) {
  return SpinKitWave(
    color: primColor,
    size: 50.0,
  );
}
String UserNameValidate(String value) {
  if (value.length == 0) {
    return "please enter name";
  }
  return null;
}

String passValidate(String value) {
  if (value.length == 0) {
    return "password is required";
  }
//  else if (value.length < 6) {
//    return "كلمة المرور يحب ان لا تقل عن 6 احرف";
//  }
  return null;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}
getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}
const KDefaultPadding=20.0;

const KDefaultShadow =BoxShadow(
  color: Colors.black26,
  offset: Offset(0,4),
  blurRadius: 4
);