// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDl83m_gMvYwMNyUeuZay6lclC6yRtKBK0',
    appId: '1:921308604401:web:0cb1df04e276f635264650',
    messagingSenderId: '921308604401',
    projectId: 'segar-chat',
    authDomain: 'segar-chat.firebaseapp.com',
    storageBucket: 'segar-chat.appspot.com',
    measurementId: 'G-QKRZ5RXLQ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS1S5-YqOt3CO00DtAtMY3ZYJpK21zCRE',
    appId: '1:921308604401:android:c77ecfc3e17f5f8a264650',
    messagingSenderId: '921308604401',
    projectId: 'segar-chat',
    storageBucket: 'segar-chat.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARRyyjpcX_nuGN2WLpXhFNM7ESeYVRIns',
    appId: '1:921308604401:ios:861db19930fee0ff264650',
    messagingSenderId: '921308604401',
    projectId: 'segar-chat',
    storageBucket: 'segar-chat.appspot.com',
    iosBundleId: 'com.segar.segarchat',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARRyyjpcX_nuGN2WLpXhFNM7ESeYVRIns',
    appId: '1:921308604401:ios:861db19930fee0ff264650',
    messagingSenderId: '921308604401',
    projectId: 'segar-chat',
    storageBucket: 'segar-chat.appspot.com',
    iosBundleId: 'com.segar.segarchat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDl83m_gMvYwMNyUeuZay6lclC6yRtKBK0',
    appId: '1:921308604401:web:209c240716f30118264650',
    messagingSenderId: '921308604401',
    projectId: 'segar-chat',
    authDomain: 'segar-chat.firebaseapp.com',
    storageBucket: 'segar-chat.appspot.com',
    measurementId: 'G-RP9VD9R7J2',
  );

}