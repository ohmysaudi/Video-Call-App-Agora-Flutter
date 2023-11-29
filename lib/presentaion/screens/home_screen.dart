import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:agoraapp/data/models/call_model.dart';
import 'package:agoraapp/data/models/user_model.dart';
import 'package:agoraapp/presentaion/cubit/home/home_cubit.dart';
import 'package:agoraapp/shared/shared_widgets.dart';

import '../../shared/constats.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/theme.dart';
import '../cubit/Auth/auth_cubit.dart';
import '../cubit/home/home_state.dart';
import '../views/home_views/home_screen_listview.dart';
import '../views/home_views/user_item_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('UserIdIs: ${CacheHelper.getString(key: 'uId')}');
    Future.delayed(const Duration(milliseconds: 1000), () {
      checkInComingTerminatedCall();
    });
  }

  checkInComingTerminatedCall() async {
    if (CacheHelper.getString(key: 'terminateIncomingCallData').isNotEmpty) {
      //if there is a terminated call
      Map<String, dynamic> callMap =
          jsonDecode(CacheHelper.getString(key: 'terminateIncomingCallData'));
      await CacheHelper.removeData(key: 'terminateIncomingCallData');
      Navigator.pushNamed(context, callScreen, arguments: [
        true,
        CallModel.fromJson(callMap),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome, ${AuthCubit.get(context).currentUser.name}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            //GetUserData States
            if (state is ErrorGetUsersState) {
              showToast(msg: state.message);
            }
            if (state is ErrorGetCallHistoryState) {
              //  showToast(msg: state.message);
            }
            //FireCall States
            if (state is ErrorFireVideoCallState) {
              // showToast(msg: state.message);
            }
            if (state is ErrorPostCallToFirestoreState) {
              showToast(msg: state.message);
            }
            if (state is ErrorUpdateUserBusyStatus) {
              showToast(msg: state.message);
            }
            if (state is SuccessFireVideoCallState) {
              Navigator.pushNamed(context, callScreen,
                  arguments: [false, state.callModel]);
            }

            //Receiver Call States
            if (state is SuccessInComingCallState) {
              Navigator.pushNamed(context, callScreen,
                  arguments: [true, state.callModel]);
            }
          },
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);
            return ModalProgressHUD(
              inAsyncCall: homeCubit.fireCallLoading,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (state is LoadingGetUsersState ||
                            state is LoadingGetCallHistoryState)
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 2.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: HomeScreenListView(
                        users: homeCubit.users,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
