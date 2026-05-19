import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau kondisi State dari ViewModel
    final authState = ref.watch(authViewModelProvider);

    return authState.when(
      data: (user) {
        if (user != null) return const HomePage();
        return const LoginPage();
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) =>
          Scaffold(body: Center(child: Text('Terjadi Kesalahan: $e'))),
    );
  }
}
