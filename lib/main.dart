import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/auth.cubit/cubit/auth_cubit.dart';
import 'package:scholar_chat/chat_cubit/cubit/chat_cubit.dart';

import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_screen.dart';
import 'package:scholar_chat/pages/register.dart';
import 'firebase_options.dart';

// FirebaseAuth auth =FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => LoginCubit(),),
        // BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => ChatCubit(),),
        BlocProvider(create: (context) => AuthCubit(),),

      ],
      child: MaterialApp(
          routes: {
            'LoginPage': (context) => LoginPage(),
            'chatpage': (context) => ChatePage(),
            RegisterScreen.id: (context) => RegisterScreen(),
          },
          initialRoute: 'LoginPage',
      
      ),
    );
  }
}
