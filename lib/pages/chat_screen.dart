//import 'dart:html';

import 'package:chat_app/constants.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
static String id ='ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
final _controller = ScrollController();

//FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);

TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   var email= ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt ,descending: true).snapshots(),
      builder: (context,snapshot){
       // print(snapshot.data!['text-message']);
        if(snapshot.hasData){
          //print(snapshot.data!.docs[0]['text-message']);
          List<Message>messagesList =[];
          for(int i =0 ;i<snapshot.data!.docs.length ;i++){
            messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false ,
              backgroundColor: Colors.deepOrange,
              title: Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo,
                    height: 70,
                    width: 70,
                  ),
                  Text('Chat',
                    style: TextStyle(
                      fontFamily: 'pacifico',
                    ),
                  )
                ],

              ),
            ),
            body:Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                      itemBuilder:(context,index){
                        return messagesList[index].id == email ? ChatBubble(
                          message:messagesList[index],
                        ):ChatBubbleForFriend(message: messagesList[index]);
                      }),

                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data){
                      messages.add(
                          {
                            kMessage:data,
                            kCreatedAt:DateTime.now(),
                            kId:email,
                          }
                      );
                      controller.clear();
                      _controller.animateTo(
                        //posision
                        0 ,
                      //time to position
                      duration:Duration(milliseconds: 500),
                      // الشكل اللي هتحرك بيه
                      curve: Curves.fastOutSlowIn,
                      );
                    },
                    style: TextStyle(fontSize:13,fontFamily: 'pacifico'),
                    cursorColor: Color(0xFF81E009),
                    decoration: InputDecoration(
                      hintText:'Send Message',
        suffixIcon: IconButton(
        icon: Icon(Icons.send),
        onPressed: () {

        }
        ),
        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }else {
          return Text('loading....');
        }
      }
    );
  }
}
