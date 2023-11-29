import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agoraapp/data/models/user_model.dart';

import '../../../shared/theme.dart';
import '../../cubit/Auth/auth_cubit.dart';

class UserItemView extends StatelessWidget {
  final UserModel userModel;
  final Function onCallTap;

  const UserItemView(
      {Key? key, required this.userModel, required this.onCallTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.person),
          const SizedBox(width: 10.0,),
          Expanded(child: Text(userModel.name)),
          GestureDetector(
              onTap: () => onCallTap(false),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                child: Icon(
                  Icons.call,
                  size: 24,
                ),
              )),
          const SizedBox(width: 14),
          GestureDetector(
              onTap: () => onCallTap(true),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                child: Icon(
                  Icons.video_call,
                  size: 24,
                ),
              )),
        ],
      ),
    );
  }
}
