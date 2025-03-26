import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu từ thông báo và hiển thị trên màn hình
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Column(
        children: [
          Text(message.notification?.title ?? "No Title"),
          Text(message.notification?.body ?? "No Body"),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
