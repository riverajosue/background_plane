import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:background_plane/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseSendNotificacionService(String? wifiName) async {

  if(wifiName == 'dsvsdf'){
    final Map<String, dynamic> decodedResp;
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = await FirebaseMessaging.instance.getToken(vapidKey: 'BM07FHl26hrq8ezg-zRsT0uqdSAGqtO-jeA6Pvsg1rEBtzQCEwUPnmWOlPOt3s7XzbDrbB1RTm-_OQWPWAIoUVc');

    //String? token =  prefs.getString('token');

    String rout = 'http://172.16.90.76:8080/api/firebase';

    var url = '${rout}/firebaseMessage/';

    Map<String, String> header = {
      "apikey": "ABCDEFG",
    };

    Map<String, String> body = {
      "token": token!,
    };

    final jsonToApi = jsonEncode(body);

    try {
      final http.Response resp =
      await http.post(Uri.parse(url), body: {'token': token}, headers: header);
      decodedResp = jsonDecode(resp.body);
      print(decodedResp);
    } catch (err){
      print('error $err');
    }
  }

}