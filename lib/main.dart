import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'services/firebase_service.dart';
import 'services/notification_service.dart';
import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  runApp(const EBuckApp());
}

class EBuckApp extends StatelessWidget {
  const EBuckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseService()),
      ],
      child: MaterialApp(
        title: 'eBuck',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const EntryPoint(),
      ),
    );
  }
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final fb = Provider.of<FirebaseService>(context);
    return StreamBuilder(
      stream: fb.authStateChanges,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) return const HomeScreen();
        return const AuthScreen();
      },
    );
  }
}