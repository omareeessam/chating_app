import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/chat_cubit/cubit/chat_cubit.dart';
import 'package:scholar_chat/models/message.dart';

import '../constants.dart';
import '../widget/chat_pubple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatePage extends StatelessWidget {
  ChatePage({Key? key}) : super(key: key);
  final _controller = ScrollController();
  List<Message> messagesList = [];
  static String id = 'chatpage';
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/scholar.png',
              height: 50,
            ),
            Text('CHAT'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                 var messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, i) {
                    return messagesList[i].id == email
                        ? ChatPuble(
                            message: messagesList[i],
                          )
                        : ChatPubleForFriend(message: messagesList[i]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email );
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
              decoration: InputDecoration(
                  hintText: 'send message',
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: kPrimaryColor),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
