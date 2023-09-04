import 'package:flutter/material.dart';

class CustomButoon extends StatelessWidget {
  CustomButoon({Key? key, this.text,this.onTap}) : super(key: key);
  String? text;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: 40,
          child: Center(child: Text(text!)),
        )
    );
  }
}
