import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'register_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  // 1. Tambahkan variabel state untuk melacak status obscure text
  bool _isObscure = true;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    // Memanggil fungsi dari ViewModel (menggunakan ref.read)
    final isSuccess = await ref
        .read(authViewModelProvider.notifier)
        .login(_usernameController.text.trim(), _passwordController.text);

    setState(() => _isLoading = false);

    if (!isSuccess && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username atau Password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login MVVM')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),

            // 2. Modifikasi bagian TextField Password
            TextField(
              controller: _passwordController,
              obscureText: _isObscure, // Gunakan variabel state
              decoration: InputDecoration(
                labelText: 'Password',
                // Tambahkan ikon mata di sebelah kanan
                suffixIcon: IconButton(
                  icon: Icon(
                    // Ubah ikon berdasarkan status _isObscure
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    // 3. Logika untuk membalikkan nilai true/false
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('LOGIN'),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              ),
              child: const Text('Belum punya akun? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
