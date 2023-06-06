import 'dart:convert';

import 'package:background_plane/src/services/firebase_service.dart';
import 'package:background_plane/src/views/home_widget.dart';
import 'package:background_plane/src/views/local_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'firebase_options.dart';

///@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
/*void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
  *//*  LocalNotification.Initializer();
    LocalNotification.ShowOneTimeNotification(DateTime.now());*//*

    final Map<String, dynamic> decodedResp;

    String rout = 'http://172.16.90.76:8080/api/countToApi';

    var url = '${rout}/contador/';

    try {
      final http.Response resp =
      await http.get(Uri.parse(url));
      decodedResp = jsonDecode(resp.body);
      print(decodedResp);
    } catch (err){
      print('error $err');
    }

   String? wifiName = await wifiDetector();
    await firebaseSendNotificacionService(wifiName);
    return Future.value(true);
  });
}*/

/*Future<String?> wifiDetector() async {
  final info = NetworkInfo();
  final wifiName = await info.getWifiName();

  String theWifi = wifiName!.substring(1,wifiName.length-1);

  return theWifi;
}*/

bool isFlutterLocalNotificationsInitialized = false;
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /*Workmanager().initialize(callbackDispatcher,
    isInDebugMode: true);*/

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,sound: true, badge: true);

/*  Workmanager().registerPeriodicTask("test_workertask", "test_workertask",
        *//*constraints: Constraints(
          networkType: NetworkType.connected,
      ),*//*

      frequency: Duration(minutes: 15),
      inputData: {"data1": "value1", "data2": "value2"},
  initialDelay: Duration(minutes: 1));*/




  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  String? token = await FirebaseMessaging.instance.getToken(vapidKey: 'BM07FHl26hrq8ezg-zRsT0uqdSAGqtO-jeA6Pvsg1rEBtzQCEwUPnmWOlPOt3s7XzbDrbB1RTm-_OQWPWAIoUVc');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('tokenRegistration', token!);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeWidget(),
    );
  }
}
