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
    apiKey: 'AIzaSyBNOJyK0zOIPF8-gRYnfIjVljYuTqaJ-M0',
    appId: '1:234499805754:web:3c22ff0193ef21f2de1b03',
    messagingSenderId: '234499805754',
    projectId: 'lost-item-recovery-network',
    authDomain: 'lost-item-recovery-network.firebaseapp.com',
    storageBucket: 'lost-item-recovery-network.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4JLnbX5XzfdmhtDfrZ8o-QgY1WEYIZ94',
    appId: '1:234499805754:android:30f8fe11854dad99de1b03',
    messagingSenderId: '234499805754',
    projectId: 'lost-item-recovery-network',
    storageBucket: 'lost-item-recovery-network.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_pgpGDzdQfSYt6C0WgHTaYlKcZmtUEqo',
    appId: '1:234499805754:ios:d46a8c887b89ac6fde1b03',
    messagingSenderId: '234499805754',
    projectId: 'lost-item-recovery-network',
    storageBucket: 'lost-item-recovery-network.appspot.com',
    iosBundleId: 'com.example.lostItemRecoveryNetwork',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_pgpGDzdQfSYt6C0WgHTaYlKcZmtUEqo',
    appId: '1:234499805754:ios:d46a8c887b89ac6fde1b03',
    messagingSenderId: '234499805754',
    projectId: 'lost-item-recovery-network',
    storageBucket: 'lost-item-recovery-network.appspot.com',
    iosBundleId: 'com.example.lostItemRecoveryNetwork',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBNOJyK0zOIPF8-gRYnfIjVljYuTqaJ-M0',
    appId: '1:234499805754:web:d3a6de4daab47c3fde1b03',
    messagingSenderId: '234499805754',
    projectId: 'lost-item-recovery-network',
    authDomain: 'lost-item-recovery-network.firebaseapp.com',
    storageBucket: 'lost-item-recovery-network.appspot.com',
  );
}
