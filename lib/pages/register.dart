import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/auth.cubit/cubit/auth_cubit.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/login_screen.dart';

import '../helper/show_snackpar.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import 'chat_page.dart';

class RegisterScreen extends StatelessWidget {
  String? email;
  static String id = 'registerpage';

  String? passsward;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      listener: (context, state) {
 if(state is RegisterLoading){
          isLoading =true;
        }else if(state is RegisterSuccess){
          Navigator.pushNamed(context, ChatePage.id);
        }else if(state is RegisterFailure){
          showSnackPar(context, 'error ');
        }      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Form(
                key: formkey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
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
                              'register',
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
                          /////////firebase  auth//////
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context)
                                  .registerUser(
                                      email: email!, passsward: passsward!);
                            } else {}
                          },
                          text: 'register',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "already have an accountt ? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text("login",
                                    style: TextStyle(color: Colors.white))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: passsward!,
    );
  }
}
