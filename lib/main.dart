import 'package:chat_app/pages/Login_Screen.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}
class ScholarChat extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =ValueNotifier(ThemeMode.light);
  const ScholarChat({Key? key}) : super(key: key);

  @override
  State<ScholarChat> createState() => _ScholarChatState();
}

class _ScholarChatState extends State<ScholarChat> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(

        valueListenable: ScholarChat.themeNotifier,

        builder: (_, ThemeMode currentMode, __){

             return MaterialApp(
               routes: {
                 LoginPage.id:(context) => LoginPage(),
                 registerScreen.id:(context) => registerScreen(),
                 ChatScreen.id:(context) => ChatScreen(),
               },
               debugShowCheckedModeBanner: false,
                theme: ThemeData(primarySwatch: Colors.deepOrange),
                        darkTheme: ThemeData.dark(),
                        themeMode: currentMode,
               initialRoute:LoginPage.id,
             );
           });
  }
}
