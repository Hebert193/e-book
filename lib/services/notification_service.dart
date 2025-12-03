import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await _messaging.requestPermission();
    final token = await _messaging.getToken();
    // Em produção: envie o token ao back-end ou salve no Firestore para segmentação
    // print('FCM Token: $token');

    FirebaseMessaging.onMessage.listen((message) {
      // tratar mensagens em primeiro plano (ex.: mostrar snackbar)
      // print('Mensagem recebida: ${message.notification?.title}');
    });
  }
}