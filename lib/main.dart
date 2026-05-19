import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/auth_wrapper.dart'; // Import wrapper-nya saja

void main() {
  // Wajib dibungkus ProviderScope agar Riverpod bisa berjalan
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE + RIVERPOD MVVM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const AuthWrapper(), // Jadikan AuthWrapper sebagai halaman awal
    );
  }
}
