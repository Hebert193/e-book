import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> signInWithEmail(String email, String pass) async {
    await _auth.signInWithEmailAndPassword(email: email, password: pass);
    notifyListeners();
  }

  Future<void> signUpWithEmail(String email, String pass) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    // opcional: criar doc do usuário
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _db.collection('users').doc(uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> saveFavorite(Map<String, dynamic> data) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('Usuário não autenticado');
    await _db.collection('users').doc(uid).collection('favorites').add(data);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> favoritesStream() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db.collection('users').doc(uid).collection('favorites').orderBy('createdAt', descending: true).snapshots();
  }
}