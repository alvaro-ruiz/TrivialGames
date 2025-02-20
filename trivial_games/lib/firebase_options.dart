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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD79hfDxdfs5-dYE8vUg5r4lltJlDzd0lw',
    appId: '1:420004673296:web:5d4e190e4f319c27001795',
    messagingSenderId: '420004673296',
    projectId: 'quiz-games-ac314',
    authDomain: 'quiz-games-ac314.firebaseapp.com',
    storageBucket: 'quiz-games-ac314.firebasestorage.app',
    measurementId: 'G-93HHBJ7HQ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHOLXCeq3nrMf9sutFOOQujDQKhVZyW1A',
    appId: '1:420004673296:android:7ae9136b4877ca9e001795',
    messagingSenderId: '420004673296',
    projectId: 'quiz-games-ac314',
    storageBucket: 'quiz-games-ac314.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD79hfDxdfs5-dYE8vUg5r4lltJlDzd0lw',
    appId: '1:420004673296:web:3ab524edf166abb0001795',
    messagingSenderId: '420004673296',
    projectId: 'quiz-games-ac314',
    authDomain: 'quiz-games-ac314.firebaseapp.com',
    storageBucket: 'quiz-games-ac314.firebasestorage.app',
    measurementId: 'G-WY26YHCTRC',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKJ3HcICXyOHNs_ixFJmhNF3kcLHrc1t4',
    appId: '1:420004673296:ios:8eff3aa8aef2ac42001795',
    messagingSenderId: '420004673296',
    projectId: 'quiz-games-ac314',
    storageBucket: 'quiz-games-ac314.firebasestorage.app',
    iosBundleId: 'com.example.trivialGames',
  );

}