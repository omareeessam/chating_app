import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({Key? key,this.hintText,this.onChange}) : super(key: key);
String? hintText;
Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      validator: (data) {
        if(data!.isEmpty){
          return 'field is required';
        }
      } ,
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )
      ),
    );
  }
}
