import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/chat-Screen.dart';
import 'package:flash_chat/login-Screen.dart';
import 'package:flash_chat/registration-Screen.dart';
import 'package:flash_chat/welcom-Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future <void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp(
options:DefaultFirebaseOptions.currentPlatform,
 );
  runApp(  FlashChat());
}
class FlashChat extends StatelessWidget {
   FlashChat({super.key});
  final _aut = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black54,
      ),
      initialRoute: _aut.currentUser != null?  ChatScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=> const WelcomeScreen(),
        LoginScreen.id  : (context)=> const LoginScreen(),
        RegistrationScreen.id  : (context)=> RegistrationScreen(),
        ChatScreen.id  : (context)=> const ChatScreen(),

      },
    );
  }
}
