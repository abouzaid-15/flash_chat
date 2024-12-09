import 'package:flash_chat/login-Screen.dart';
import 'package:flash_chat/registration-Screen.dart';
import'package:animated_text_kit/animated_text_kit.dart';


import 'package:flutter/material.dart';

import 'buildpadding.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome-screen';

  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();

}
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
late AnimationController controller;
late Animation animation;
@override
  void initState() {

    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 4,),vsync: this,);

    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    //                                       ou bien :     Curves.decelerate
    animation=ColorTween(begin : Colors.blueGrey  , end: Colors.white).animate(controller);
    controller.forward();
       // ce type d'animation utilise lorsque on veut aggrandir.
    // animation.addStatusListener((Status){
    //   if(Status==AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   }else if (Status == AnimationStatus.dismissed){
    //     controller.forward();
    //     //ou bien: controller.reverse();
    //   }
    //   },);
    controller.addListener(() {
        setState(() {});
        print(animation.value);
    },);
  }
  @override
  void dispose() {

    super.dispose();
    controller.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'log',
                  child: SizedBox(
                    height:60,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle:  const TextStyle(
                        fontSize: 40.0,color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 1000),
                    ),
                  ],

                  totalRepeatCount: 4,
                  pause:  const Duration(seconds: 5),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
             // TyperAnimatedTextKit(
             //      text:['Flash Chat'],textStyle: TextStyle(fontSize: 40,color:Colors.black,fontWeight: FontWeight.w900), ),
              ],
            ),
            const SizedBox(height: 48,),

            Buildpadding(
              onpressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
              coleur: Colors.lightBlueAccent,
              title: 'log in',
            ),

        Buildpadding(
            onpressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
            coleur: Colors.blueAccent,
            title: 'Register',
        ),

          ],
        ),
      ),
    );
  }
}