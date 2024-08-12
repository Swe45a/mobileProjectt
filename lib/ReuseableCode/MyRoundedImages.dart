import 'package:flutter/material.dart';


class MyRoundedImages extends StatelessWidget {
  final String? imagePath;

  const MyRoundedImages({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/$imagePath"),
        ),
        border: Border.all(width: 6, color: Colors.green),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 5.5,
            color: Colors.red,
            blurRadius: 4.5,
            blurStyle: BlurStyle.normal,
          )
        ],
      ),
    );
  }
}