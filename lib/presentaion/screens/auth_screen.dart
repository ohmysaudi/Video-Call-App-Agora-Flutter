import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agoraapp/shared/constats.dart';

import '../../shared/network/cache_helper.dart';
import '../../shared/shared_widgets.dart';
import '../../shared/theme.dart';
import '../cubit/Auth/auth_cubit.dart';
import '../cubit/Auth/auth_state.dart';

enum AuthOptions {
  login('Login', LoginView()),
  register('Register', RegisterView());

  final String name;
  final Widget view;

  const AuthOptions(this.name, this.view);
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, state) {
          if (state is SuccessLoginState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeScreen, (route) => false);
            });
          }
          if (state is SuccessRegisterState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeScreen, (route) => false);
            });
          }
          if (state is ErrorRegisterState) {
            showToast(
              msg: state.errorMessage,
            );
          }
          if (state is ErrorLoginState) {
            showToast(
              msg: state.errorMessage,
            );
          }
          if (state is ErrorGetUserDataState) {
            showToast(
              msg: state.errorMessage,
            );
          }
          if (state is SuccessGetUserDataState) {
            Navigator.pushNamedAndRemoveUntil(
                context, homeScreen, (route) => false);
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: DefaultTabController(
            length: AuthOptions.values.length,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: AuthOptions.values.map((e) => e.view).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, state) {
        var authCubit = AuthCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Please sign in to continue",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: state is! LoadingLoginState
                          ? ElevatedButton(
                              onPressed: () {
                                if (emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  authCubit.login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                } else {
                                  showToast(msg: 'Please fill req data');
                                }
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 21),
                              ))
                          : const CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                      onTap: () {
                        DefaultTabController.of(context).animateTo(1);
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, state) {
        var authCubit = AuthCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Signup",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Please enter fields to signup",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: state is! LoadingRegisterState
                          ? ElevatedButton(
                          onPressed: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                nameController.text.isNotEmpty) {
                              authCubit.register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text);
                            } else {
                              showToast(msg: 'Please fill req data');
                            }
                          },
                          child: const Text('Register'))
                          : const CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                      onTap: () {
                        DefaultTabController.of(context).animateTo(0);
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
