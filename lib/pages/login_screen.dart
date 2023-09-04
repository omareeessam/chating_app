
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/auth.cubit/cubit/auth_cubit.dart';
import 'package:scholar_chat/chat_cubit/cubit/chat_cubit.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register.dart';
import 'package:scholar_chat/widget/custom_button.dart';

import '../helper/show_snackpar.dart';
import '../widget/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  String? email;
  String? passsward;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthState>(
      listener: (context, state) {
        if(state is LoginLoading){
          isLoading =true;
        }else if(state is LoginSuccess){
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushNamed(context, ChatePage.id);
        }else if(state is LoginFailure){
          showSnackPar(context, 'error ');
        }
      },
      child:  ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Form(
              key: formkey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Image.asset("assets/images/scholar.png"),
                        Text(
                          'Scholar chat',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontFamily: 'pacifico'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          onChange: (data) {
                            email = data;
                          },
                          hintText: 'email',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          onChange: (data) {
                            passsward = data;
                          },
                          hintText: 'password',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButoon(
                          onTap: () async {
                           BlocProvider.of<AuthCubit>(context).loginUser(email: email!, passsward: passsward!);
                            if (formkey.currentState!.validate()) {
                              isLoading = true;
                              try {
                                await loginUser();
                                showSnackPar(context, 'success');
                                Navigator.pushNamed(context, ChatePage.id,
                                    arguments: email!);
                              } catch(e)
                              {
                                print(e);
                              }
                              isLoading = false;
                            } else {}
                          },
                          text: 'login',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "don't have an account ? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.id);
                                },
                                child: Text("register",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: passsward!,
    );
  }
}
