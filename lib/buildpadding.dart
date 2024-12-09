
import 'package:flutter/material.dart';
class Buildpadding extends StatelessWidget {
  const Buildpadding({super.key, required this.onpressed,required this.coleur,required this.title});

  final VoidCallback onpressed;
  final Color coleur;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        onPressed:onpressed ,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

        color: coleur,
        child: Text(title,style: const TextStyle(color: Colors.black),),
      ),
    );
  }
}
