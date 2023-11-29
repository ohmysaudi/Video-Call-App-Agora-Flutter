import 'package:agoraapp/data/models/user_model.dart';

class CallModel {
  late String id;
  String? token;
  String? channelName;
  String? callerId;
  String? callerName;
  String? receiverId;
  String? receiverName;
  String? status;
  num? createAt;
  bool? isVideo;
  bool? current;
  UserModel? otherUser; //UI

  CallModel(
      {required this.id,
      this.callerId,
      this.callerName,
      this.receiverId,
      this.receiverName,
      this.status,
      this.createAt,this.isVideo, this.current});

  CallModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    channelName = json['channelName'];
    callerId = json['callerId'];
    callerName = json['callerName'];
    receiverId = json['receiverId'];
    receiverName = json['receiverName'];
    status = json['status'];
    createAt = json['createAt'];
    isVideo = json['isVideo'];
    current = json['current'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'token': token,
      'channelName': channelName,
      'callerId': callerId,
      'callerName': callerName,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'status': status,
      'createAt': createAt,
      'isVideo': isVideo,
      'current': current
    };
  }
}
