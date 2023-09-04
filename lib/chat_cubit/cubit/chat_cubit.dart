import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/models/message.dart';

import '../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
              List<Message> messagesList = [];

  void sendMessage({required String message, required String email}) {
    messages.add(
      ({kMessage: message, kcreatedat: DateTime.now(), 'id': email}),
    );
  }

 void getMessage(){
  messages.orderBy(kcreatedat, descending: true).snapshots().listen((event) {
    for(var doc in event.docs){
       messagesList.add(Message.fromjson(doc)); 
    }
    emit(ChatMessageSuccess(messages: messagesList));
  });

 }
}
