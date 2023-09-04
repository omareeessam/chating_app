part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatMessageSuccess extends ChatState {
    List<Message> messages ;
 ChatMessageSuccess({required this.messages});
}

