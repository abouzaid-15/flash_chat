 import 'package:flutter/material.dart';

const kTexteField =  InputDecoration(

  contentPadding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
   enabledBorder:  OutlineInputBorder( borderSide: BorderSide(color: Colors.blueAccent,width: 1),
     borderRadius: BorderRadius.all(Radius.circular(32.0)),
   ),
   focusedBorder:  OutlineInputBorder(borderSide: BorderSide(
       color: Colors.blueAccent,width: 2),
     borderRadius: BorderRadius.all(Radius.circular(32.0)),
   ),
 );

const kSendmessageText = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.lightBlueAccent,
  ),
  icon: Icon(Icons.message,color: Colors.lightBlueAccent,size: 30,),
  contentPadding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
  enabledBorder:  OutlineInputBorder( borderSide: BorderSide(color: Colors.blueAccent,width: 1),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder:  OutlineInputBorder(borderSide: BorderSide(
      color: Colors.blueAccent,width: 2),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),

);