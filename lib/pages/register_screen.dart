import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/Login_Screen.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show-snack-bar.dart';

class registerScreen extends StatefulWidget {
   registerScreen({Key? key}) : super(key: key);
static String id =  'RegisterPage' ;

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
String? email ;

String? password;

bool isloading  = false ;

//work on form
GlobalKey<FormState>formKye =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      //معناه ان التحميل هيبقا مخفي
      inAsyncCall:isloading ,
      child: Scaffold(
        //backgroundColor:kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),

          child: Form(
            key: formKye,
            child: ListView(
              children: [
               // Spacer(flex: 1,),
                SizedBox(height:75,),
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
               // Spacer(flex: 2,),
                SizedBox(height: 55,),
                //text login
                Row(
                  children: [
                    Text('Register',
                      style: TextStyle(
                        fontSize: 18 ,
                        fontWeight: FontWeight.w400,
                        color:Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                customFormTextField.customFormTextField(
                 onChange: (data){
                   email =data ;
                 },
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 5,
                ),
                customFormTextField.customFormTextField(
                  onChange: (data){
                    password = data;
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
                        await registerUser();
                        Navigator.pushNamed(context,LoginPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email-already-in-use');
                        }
                      } catch (e) {
                        showSnackBar(context, 'There Was an Error');
                      }
                       isloading=false;
                      setState(()  {

                     } );
                    }else
                      {

                      }
                  },
                  text: 'REGISTER',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                      style: TextStyle(
                        color:Colors.deepOrange,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text('  Login',
                        style: TextStyle(
                          color:   Colors.lightBlue,
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

 // void showSnackBar(BuildContext context ,String message) {
   // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
 // }

   Future<void>registerUser() async{
     UserCredential user  =await  FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email!, password: password!);
   }
}

