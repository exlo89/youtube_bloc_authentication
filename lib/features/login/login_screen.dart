import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_template/bloc/authentication/authentication_bloc.dart';
import 'package:youtube_template/features/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'E-Mail'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte geben Sie Ihre E-Mail ein';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Passwort'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Bitte geben Sie Ihr Passwort ein';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            AuthenticationLoggedIn(
                              _emailController.text,
                              _passwordController.text,
                            ),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
