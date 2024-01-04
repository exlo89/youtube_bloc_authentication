part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationAppStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLoggedIn(this.email, this.password);
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
