
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }


  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD159YZq1OIOzZWt3afJMPt5uZrx6tWOmQ',
    appId: '1:684065463656:web:e1f01faf01915f91a0cadd',
    messagingSenderId: '684065463656',
    projectId: 'vibe-1ddcc',
    authDomain: 'vibe-1ddcc.firebaseapp.com',
    storageBucket: 'vibe-1ddcc.firebasestorage.app',
    measurementId: 'G-2BJ6ERCDHH',
  );


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD159YZq1OIOzZWt3afJMPt5uZrx6tWOmQ',
    appId: '1:684065463656:android:319726217646ed6e0cadd',
    messagingSenderId: '684065463656',
    projectId: 'vibe-1ddcc',
    storageBucket: 'vibe-1ddcc.firebasestorage.app',
  );
}