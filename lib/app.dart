import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_template/bloc/authentication/authentication_bloc.dart';
import 'package:youtube_template/features/home/home_screen.dart';
import 'package:youtube_template/features/login/login_screen.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc();
    authenticationBloc.add(AuthenticationAppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: authenticationBloc,
        buildWhen: (previous, current) =>
            current is AuthenticationAuthenticated ||
            current is AuthenticationUnauthenticated,
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            title: 'Bloc Authentication',
            routes: {
              "login": (context) => const LoginScreen(),
              "home": (context) => const HomeScreen(),
            },
            home: state is AuthenticationAuthenticated
                ? const HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
