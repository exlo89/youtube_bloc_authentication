import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_template/bloc/authentication/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut());
            },
          ),
        ],
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthenticationInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text('Home Screen'),
          );
        },
      ),
    );
  }
}
