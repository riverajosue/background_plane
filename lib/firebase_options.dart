// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgwSQGnUmPd-OwZOruaLOK43zhEW1wfQo',
    appId: '1:803005100742:android:a41790e6ae291aa4ad9dc7',
    messagingSenderId: '803005100742',
    projectId: 'fir-pushnotification-dd17d',
    storageBucket: 'fir-pushnotification-dd17d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCeK9dlRxV8T6ZIf8B-sEey6jlox7zXeZI',
    appId: '1:803005100742:ios:ceb9bb021ea3c76ead9dc7',
    messagingSenderId: '803005100742',
    projectId: 'fir-pushnotification-dd17d',
    storageBucket: 'fir-pushnotification-dd17d.appspot.com',
    iosClientId: '803005100742-eg2up9eocd0sa3gfbk7n9oi88e0ar6m0.apps.googleusercontent.com',
    iosBundleId: 'com.example.backgroundPlane',
  );
}
