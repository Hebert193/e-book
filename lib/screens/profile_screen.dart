
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fb = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${fb.currentUser?.email ?? "-"}'),
            const SizedBox(height: 12),
            const Text('Favoritos recentes:'),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder(
                stream: fb.favoritesStream(),
                builder: (ctx, snapshot) {
                  if (!snapshot.hasData) return const Center(child: Text('Nenhum favorito ainda'));
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (c, i) {
                      final d = docs[i].data();
                      return ListTile(
                        title: Text(d['title'] ?? 'Sem título'),
                        subtitle: Text(d['createdAt'] ?? ''),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}