part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String error;

  AuthenticationFailure(this.error);
}
