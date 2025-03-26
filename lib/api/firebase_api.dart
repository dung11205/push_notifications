import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// Định nghĩa một khóa Navigator để điều hướng khi có thông báo
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseApi {
  // Tạo một thể hiện của Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Hàm khởi tạo thông báo đẩy
  Future<void> initNotifications() async {
    // Yêu cầu quyền từ người dùng
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User denied permission');
      return;
    }

    // Lấy token của thiết bị
    final String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      print('FCM Token: $fcmToken');
    }
  }

  // Hàm xử lý tin nhắn nhận được
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Chuyển hướng sang màn hình thông báo khi người dùng nhấn vào thông báo
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // Khởi tạo lắng nghe thông báo khi ứng dụng chạy nền hoặc bị tắt
  Future<void> initPushNotifications() async {
    // Kiểm tra nếu ứng dụng được mở từ trạng thái bị tắt hoàn toàn (terminated)
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // Khi người dùng nhấn vào thông báo và ứng dụng đang chạy nền
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Xử lý khi nhận thông báo trong khi ứng dụng đang chạy
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received a foreground message: ${message.notification?.title}");

      // Hiển thị thông báo dạng SnackBar (hoặc cập nhật UI theo yêu cầu)
      navigatorKey.currentState?.overlay?.context;
    });
  }
}
