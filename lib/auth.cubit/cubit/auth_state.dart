part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginInitial extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginLoading extends AuthState {}
class LoginFailure extends AuthState {}


class RegisterInitial extends AuthState {}
class RegisterSuccess extends AuthState {}
class RegisterLoading extends AuthState {}
class RegisterFailure extends AuthState {}

