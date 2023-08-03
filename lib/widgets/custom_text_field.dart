import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class customFormTextField extends StatelessWidget {
   customFormTextField.customFormTextField({this.onChange ,required this.hintText,this.obscureText=false});
   String? hintText;
   Function(String)? onChange  ;
   bool? obscureText ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText!,
      validator: (data) {
        if(data!.isEmpty){
          return 'Filed is Required';
        }
      },
      onChanged:onChange ,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color:Colors.deepOrange ,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius:BorderRadius.horizontal(
              left: Radius.circular(20),
              right: Radius.circular(20),
            ),
            borderSide: BorderSide(
              color: Colors.deepOrange,

            )
        ),
        border:OutlineInputBorder(
            borderSide: BorderSide(
              color:Colors.deepOrange,

            )
        ),
      ),
    );
  }
}
