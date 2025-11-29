import 'package:flutter/material.dart';
import 'package:flutter_appstar/service/controller';

import 'models/place';
import 'pages/tela detalhes';
import 'pages/tela inicial';
import 'pages/tela principal';


// -----------------------------------------------------------------------------
// ARQUITETURA DO APP (Material App e Inicialização)
// -----------------------------------------------------------------------------

// Instâncias dos serviços (simuladas como Singletons simples)
final AuthService authService = AuthService();
final ApiService apiService = ApiService();
final FirestoreService firestoreService = FirestoreService();
final NotificationService notificationService = NotificationService();

void main() {
  // Lógica de inicialização real:
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // notificationService.initialize();
  // notificationService.scheduleLocalNotification(
  //     'Lembrete: Chuva de Meteoros hoje!',
  //     DateTime.now().add(const Duration(seconds: 10)));

  runApp(const StarGazerApp());
}

class StarGazerApp extends StatelessWidget {
  const StarGazerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarGazer App',
      theme: ThemeData(
        // Tema exclusivo: Dark, cores de espaço
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        cardColor: const Color(0xFF1A1A3A), // Roxo escuro para cards
        useMaterial3: true,
      ),
      // Roteamento básico
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/main': (context) => const MainScreen(),
        '/details': (context) => DetailScreen(
              observacao: Observacao(
                id: 'dummy',
                nome: 'Dados de Teste',
                descricao: 'Esta é uma observação para testes.',
                urlImagem:
                    'https://placehold.co/600x400/000000/FFFFFF?text=Teste',
              ),
            ),
      },
    );
  }
}
