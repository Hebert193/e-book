
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ebuck_item.dart';
import '../services/firebase_service.dart';
import '../services/native_service.dart';

class DetailScreen extends StatefulWidget {
  final EBuckItem? item;
  final bool imageMode;
  const DetailScreen({super.key, this.item, this.imageMode = false});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File? _image;
  String _location = '';
  bool _saving = false;

  Future<void> _saveFavorite() async {
    final fb = Provider.of<FirebaseService>(context, listen: false);
    final data = {
      'title': widget.item?.title ?? 'Foto do usuário',
      'desc': widget.item?.description ?? '',
      'image_local_path': _image?.path ?? '',
      'createdAt': DateTime.now().toIso8601String(),
    };
    setState(() => _saving = true);
    try {
      await fb.saveFavorite(data);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Salvo nos favoritos!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _pickImage() async {
    final file = await NativeService.pickImageFromGallery();
    if (file != null) setState(() => _image = file);
  }

  Future<void> _takePhoto() async {
    final file = await NativeService.takePhoto();
    if (file != null) setState(() => _image = file);
  }

  Future<void> _getLocation() async {
    try {
      final pos = await NativeService.getCurrentLocation();
      setState(() => _location = '${pos.latitude}, ${pos.longitude}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item?.title ?? 'Detalhes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_image != null) Image.file(_image!, height: 200),
            if (_image == null && widget.item != null)
              Container(height: 200, color: Colors.grey[200], child: Center(child: Text(widget.item!.title))),
            const SizedBox(height: 12),
            Text(widget.item?.description ?? 'Use a câmera para capturar um buck e salvar.'),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(onPressed: _pickImage, icon: const Icon(Icons.photo), label: const Text('Galeria')),
                const SizedBox(width: 8),
                ElevatedButton.icon(onPressed: _takePhoto, icon: const Icon(Icons.camera_alt), label: const Text('Câmera')),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(onPressed: _getLocation, icon: const Icon(Icons.place), label: const Text('Marcar localização')),
            if (_location.isNotEmpty) Text('Localização: $_location'),
            const Spacer(),
            if (_saving) const CircularProgressIndicator(),
            if (!_saving)
              ElevatedButton.icon(onPressed: _saveFavorite, icon: const Icon(Icons.favorite), label: const Text('Salvar favoritos')),
          ],
        ),
      ),
    );
  }
}