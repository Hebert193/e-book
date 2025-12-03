import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _isLogin = true;
  bool _loading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final fb = Provider.of<FirebaseService>(context, listen: false);
      if (_isLogin) {
        await fb.signInWithEmail(_emailCtrl.text.trim(), _passCtrl.text.trim());
      } else {
        await fb.signUpWithEmail(_emailCtrl.text.trim(), _passCtrl.text.trim());
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('eBuck — Entrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => v != null && v.contains('@') ? null : 'Email inválido',
                      ),
                      TextFormField(
                        controller: _passCtrl,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                        validator: (v) => v != null && v.length >= 6 ? null : 'Senha precisa ter >= 6 caracteres',
                      ),
                      const SizedBox(height: 12),
                      if (_loading) const CircularProgressIndicator(),
                      if (!_loading)
                        ElevatedButton(onPressed: _submit, child: Text(_isLogin ? 'Entrar' : 'Cadastrar')),
                      TextButton(onPressed: () => setState(() => _isLogin = !_isLogin), child: Text(_isLogin ? 'Criar conta' : 'Já tenho conta')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}