import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agoraapp/data/models/call_model.dart';
import 'package:agoraapp/presentaion/cubit/call/call_cubit.dart';
import 'package:agoraapp/presentaion/screens/call_screen.dart';
import 'package:agoraapp/presentaion/screens/home_screen.dart';
import 'package:agoraapp/presentaion/screens/auth_screen.dart';
import 'package:agoraapp/shared/constats.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const AuthScreen();
          },
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) {
            return const HomeScreen();
          },
        );


      case callScreen:
        List<dynamic> args = routeSettings.arguments as List<dynamic>;
        final isReceiver = args[0] as bool;
        final callModel = args[1] as CallModel;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(create: (_) => CallCubit(),
            child: CallScreen(isReceiver: isReceiver,callModel: callModel));
          },
        );


    }
  }
}
