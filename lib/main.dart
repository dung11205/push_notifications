import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_notifications/api/firebase_api.dart';
import 'package:flutter_push_notifications/firebase_options.dart';
import 'package:flutter_push_notifications/pages/notification_page.dart';

import 'pages/home_page.dart';


final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Khởi tạo Firebase thông báo
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      navigatorKey: navigatorKey,
      routes: {
        '/notification_screen':(context)=>const NotificationPage(),
      },
    );
  }
}
