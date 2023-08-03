import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key ,required this.message}) : super(key: key);
final  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16 ,bottom: 16 ,top: 16,right: 16),
        margin: EdgeInsets.symmetric(horizontal: 17,vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: Colors.deepOrange,
        ),
        child: Text(message.text,
          style: TextStyle(
            color:Colors.white,
          ),
        ),
      ),
    );
  }
}
class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({Key? key ,required this.message}) : super(key: key);
  final  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16 ,bottom: 16 ,top: 16,right: 16),
        margin: EdgeInsets.symmetric(horizontal: 17,vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Colors.orange,
        ),
        child: Text(message.text,
          style: TextStyle(
            color:Colors.white,
          ),
        ),
      ),
    );
  }
}
