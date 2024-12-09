import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/chat-Screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'buildpadding.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registerscreen';

  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email='';

  String password = '';

  final _aut = FirebaseAuth.instance;

  bool showSpinner= false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.blue,),
      ),),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              TextField(
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value){
                  email = value;
                },
                decoration: kTexteField.copyWith(

                  hintText: 'enter your email',

                ),
              ),
              const SizedBox(height: 8,),
              TextField(
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value){
                  password=value;

                },
                decoration: kTexteField.copyWith(
                  hintText: 'enter you password',
                ),
              ),
              const SizedBox(height: 10,),



              Buildpadding(
                onpressed: () async{
                  setState(() {});
                  showSpinner = true;
                try {
                  final newUser = await _aut.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.id);
                              }
                catch(e){
                  print('erreur');
                }
                setState(() {});
                showSpinner = false;
                },
                coleur: Colors.blueAccent,
                title:'Register'
              ),
            ],
          ),
        ),
      ),
    );
  }
}