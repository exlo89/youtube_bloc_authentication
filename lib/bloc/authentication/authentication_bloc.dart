import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationAppStarted>(_onAppStarted);
    on<AuthenticationLoggedIn>(_onLoggedIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(event, emit) async {
    try {
      // Gib mir bitte mein Token, den ich local auf den smartphone gespeichert habe.
      await Future.delayed(const Duration(seconds: 3));
      String token = 'secret_token';
      // der token ist ja leer. nee dann bist du gar nicht eingeloggt
      if (token.isNotEmpty) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    } catch (error) {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(event, emit) async {
    try {
      emit(AuthenticationInProgress());
      await Future.delayed(const Duration(seconds: 3));
      // _repository.login(event.email, event.password);
      String token = 'secret_token';
      emit(AuthenticationAuthenticated());
    } catch (error) {
      emit(AuthenticationFailure(error.toString()));
    }
  }

  Future<void> _onLoggedOut(event, emit) async {
    try {
      emit(AuthenticationInProgress());
      await Future.delayed(const Duration(seconds: 3));
      String token = '';
      emit(AuthenticationUnauthenticated());
    } catch (error) {
      emit(AuthenticationFailure(error.toString()));
    }
  }
}
