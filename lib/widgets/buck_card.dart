import 'package:flutter/material.dart';
import '../models/ebuck_item.dart';

class BuckCard extends StatelessWidget {
  final EBuckItem item;
  final VoidCallback onTap;
  const BuckCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(item.title),
        subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        leading: const CircleAvatar(child: Icon(Icons.card_giftcard)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}