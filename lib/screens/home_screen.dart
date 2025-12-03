
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/ebuck_item.dart';
import '../widgets/buck_card.dart';
import 'detail_screen.dart';
import '../services/firebase_service.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<EBuckItem>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = ApiService.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    final fb = Provider.of<FirebaseService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('eBuck'),
        actions: [
          IconButton(onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())), icon: const Icon(Icons.person)),
          IconButton(onPressed: () => fb.signOut(), icon: const Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<List<EBuckItem>>(
        future: _itemsFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Erro: ${snapshot.error}'));
          final items = snapshot.data ?? [];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) => BuckCard(
              item: items[i],
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailScreen(item: items[i]))),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DetailScreen(imageMode: true))),
      ),
    );
  }
}



