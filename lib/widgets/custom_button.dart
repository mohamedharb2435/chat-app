import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
   customButton({ this.onTap,required this.text}) ;

   String? text;
VoidCallback? onTap ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          color:Colors.deepOrange,
          borderRadius: BorderRadius.circular(20),
        ),
        height:50,
        width: double.infinity,
        child: Center(child: Text(text!,
        style: TextStyle(
          color: kPrimaryColor,
          fontWeight: FontWeight.w900,
        ),)),
      ),
    );
  }
}
