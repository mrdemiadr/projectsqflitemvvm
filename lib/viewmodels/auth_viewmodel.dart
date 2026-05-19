import 'dart:async'; // Dibutuhkan untuk AsyncNotifier
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';

// 1. Menggunakan AsyncNotifierProvider (Standar Baru Riverpod 2.0+)
// Perhatikan bahwa tipe datanya adalah String? (bukan AsyncValue<String?>)
// karena AsyncNotifierProvider otomatis membungkusnya dengan AsyncValue.
final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, String?>(() {
  return AuthViewModel();
});

// 2. Menggunakan AsyncNotifier sebagai pengganti StateNotifier
class AuthViewModel extends AsyncNotifier<String?> {
  // 3. Fungsi build() adalah standar baru untuk inisialisasi awal.
  // Ini menggantikan checkSession() dan konstruktor dari versi lama.
  @override
  Future<String?> build() async {
    // Karena AsyncNotifier memiliki akses bawaan ke 'ref',
    // kita bisa langsung memanggil repository di sini.
    final repository = ref.watch(authRepositoryProvider);

    // Beri sedikit jeda agar animasi loading di awal terlihat (Opsional)
    await Future.delayed(const Duration(seconds: 1));

    // Mengembalikan data langsung (otomatis menjadi AsyncData)
    return await repository.getSessionUser();
  }

  // 4. Fungsi-fungsi aksi (Mutations)
  Future<bool> login(String username, String password) async {
    // Menggunakan ref.read untuk membaca aksi dari repository
    final repository = ref.read(authRepositoryProvider);

    final user = await repository.login(username, password);

    if (user != null) {
      // Mengubah state ke AsyncData (Sukses) untuk memicu perubahan UI
      state = AsyncData(user.username);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();

    // Menghapus data state (Otomatis memicu UI melempar user ke halaman Login)
    state = const AsyncData(null);
  }
}
