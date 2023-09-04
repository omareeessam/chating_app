import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/message.dart';

class ChatPuble extends StatelessWidget {
   ChatPuble({Key? key,required this.message}) : super(key: key);
 final Message message;
  @override
  Widget build(BuildContext context) {
       return Align(
         alignment: Alignment.centerLeft,
         child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.only(left: 16,top: 16,bottom: 16,right: 10),
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
            child: Text(message.message,style: TextStyle(color: Colors.white),),
          ),
       );
  }
}
class ChatPubleForFriend extends StatelessWidget {
  ChatPubleForFriend({Key? key,required this.message}) : super(key: key);
 final Message message;
  @override
  Widget build(BuildContext context) {
       return Align(
         alignment: Alignment.centerRight,
         child: Container(
            margin: EdgeInsets.all(7),
            padding: EdgeInsets.only(left: 16,top: 16,bottom: 16,right: 10),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )),
            child: Text(message.message,style: TextStyle(color: Colors.white),),
          ),
       );
  }
}