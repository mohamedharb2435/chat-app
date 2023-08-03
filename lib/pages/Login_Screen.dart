import 'package:chat_app/constants.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show-snack-bar.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);
   static String  id ='LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 bool isloading =false ;
 String? email , password ;


   //work on form
   GlobalKey<FormState>formKye =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(ScholarChat.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  ScholarChat.themeNotifier.value =
                  ScholarChat.themeNotifier.value == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                })
          ],
        ),
      // backgroundColor:ThemeMode.light ,
        body: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKye,
            child: ListView(

              children: [
                SizedBox(height: 20,),
               // Spacer(flex: 1,),
                Image.asset('assets/images/oo.png',
                height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chat app',
                    style: TextStyle(
                      fontSize: 32 ,
                      fontFamily:'pacifico',
                      color:Colors.deepOrange,
                    ),
                    ),
                  ],
                ),
                SizedBox(height:55,),
                //Spacer(flex: 2,),
                //text login
                Row(
                  children: [
                    Text('LOGIN',
                      style: TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.w400,
                        color:Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                 height:5,
               ),
               customFormTextField.customFormTextField(
                 onChange: (data){
                   email=data;
                 },
                 hintText: 'Email',
               ),
                SizedBox(
                  height: 5,
                ),
                customFormTextField.customFormTextField(
                  obscureText:true,
                  onChange:(data){
                    password=data;
                  },
                  hintText: 'Password',
                ),
                SizedBox(
                  height: 20,
                ),
                //button login
                customButton(
                  onTap: ()async{
                    if(formKye.currentState!.validate()) {
                      isloading =true ;
                      setState(() {

                      });
                      try {
                        await loginUser();
                       Navigator.pushNamed(context, ChatScreen.id ,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user-not-found');
                        } else if (e.code == 'worng-password') {
                          showSnackBar(context, 'worng-password');
                        }
                      } catch (e) {
                        showSnackBar(context, 'There Was an Error');
                      }
                      isloading=false ;
                      setState(()  {

                      } );
                    }else
                    {

                    }
                  },
                  text: 'LOGIN',
                ),
                SizedBox(
                  height: 10,
                ),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
      Text('dont\'t have an account ?',
        style: TextStyle(
            color: Colors.deepOrange,
        ),
      ),
      GestureDetector(
        onTap: (){
        Navigator.pushNamed(context,registerScreen.id);
        },
        child: Text('  Register',
            style: TextStyle(
              color:  Colors.lightBlue,
            ),
        ),
      ),



  ],
),

               // Spacer(flex: 3,),
              ],
            ),
          ),
        ),
      ),
    );
  }
 Future<void>loginUser() async{
   UserCredential user  =await  FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email!, password: password!);
 }
}

