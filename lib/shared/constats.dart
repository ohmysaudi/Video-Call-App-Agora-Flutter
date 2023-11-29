//Firebase
const userCollection = 'Users';
const callsCollection = 'Calls';
const tokensCollection = 'Tokens';

const fcmKey = 'AAAAIQtwoh4:APA91bERDjGEvGzIpSTpbZLWMNwNOTchyrxiSuDNmNhqPn8BhLGx9iXv56R433v7Z0bGc0LkZjxEvp5QCc5vhZeR1l3USn7bJH8huYcYuCOvZFOTFLBdbMNJfqzERpt38-QpGEOjbEuc'; //replace with your Fcm key
//Routes
const loginScreen = '/';
const homeScreen = '/homeScreen';
const callScreen = '/callScreen';
const testScreen = '/testScreen';



//Agora
const agoraAppId = '594e364448004f0b8f3f83c1cd7952e6'; //replace with your agora app id
const agoraTestChannelName = 'channelForVc'; //replace with your agora channel name
const agoraTestToken = '007eJxTYCg18rryszvlc8xu7Tl1YvURyuut29ruheUy/76iEJy0vFuBwdTSJNXYzMTExMLAwCTNIMkizTjNwjjZMDnF3NLUKNXM6HNaakMgIwNz7jZmRgYIBPF5GJIzEvPyUnPc8ovCkhkYACZUIYI='; //replace with your agora token

const int callDurationInSec = 45;

//Call Status
enum CallStatus {
  none,
  ringing,
  accept,
  reject,
  unAnswer,
  cancel,
  end,
}