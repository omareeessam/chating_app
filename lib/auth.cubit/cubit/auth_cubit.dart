import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  
  Future<void> loginUser({required String email,required String passsward}) async {
  emit(LoginLoading());
    try {
  UserCredential user =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: passsward,
  );
  emit(LoginSuccess());
    }on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                emit(LoginFailure());
                                } 
                                else if (e.code == 'wrong-password') {
emit(LoginFailure());
                                }
                              }
    
 catch (e) {
  emit(LoginFailure());
}
    
  }


  
 Future<void> registerUser({required String email,required String passsward}) async {
    emit(RegisterLoading());
    try {
  UserCredential user =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: passsward,
  );
   emit(RegisterSuccess());
        

}on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                            } else if (e.code == 'email-already-in-use') {
                            }
                          } 

on Exception catch (e) {
   emit(RegisterFailure());
}
    }
}
