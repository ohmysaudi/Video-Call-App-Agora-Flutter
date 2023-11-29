import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agoraapp/presentaion/views/home_views/user_item_view.dart';

import '../../../data/models/call_model.dart';
import '../../../data/models/user_model.dart';
import '../../../shared/constats.dart';
import '../../../shared/network/cache_helper.dart';
import '../../../shared/shared_widgets.dart';
import '../../cubit/Auth/auth_cubit.dart';
import '../../cubit/home/home_cubit.dart';

class HomeScreenListView extends StatelessWidget {
  final List<UserModel> users;
  const HomeScreenListView({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
            return UserItemView(
              userModel: users[index],
              onCallTap: (bool? isVideo) {
                if(!(users[index].busy ?? false)){
                  HomeCubit.get(context).fireVideoCall(
                      callModel: CallModel(
                          id: 'call_${UniqueKey().hashCode.toString()}',
                          callerId: CacheHelper.getString(key: 'uId'),
                          callerName: AuthCubit.get(context).currentUser.name,
                          receiverId: users[index].id,
                          receiverName:users[index].name,
                          status: CallStatus.ringing.name,
                          isVideo: isVideo,
                          createAt: DateTime.now().millisecondsSinceEpoch,
                        current: true
                      ));
                }else{
                 showToast(msg: 'User is busy');
                }

              },
            );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: users.length);
  }
}
