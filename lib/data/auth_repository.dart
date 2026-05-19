import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'database_helper.dart';

// Provider untuk Repository agar mudah disuntikkan ke ViewModel
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(DatabaseHelper.instance, const FlutterSecureStorage());
});

class AuthRepository {
  final DatabaseHelper _dbHelper;
  final FlutterSecureStorage _storage;

  AuthRepository(this._dbHelper, this._storage);

  Future<bool> register(String username, String password) async {
    final newUser = UserModel(username: username, password: password);
    return await _dbHelper.insertUser(newUser);
  }

  Future<UserModel?> login(String username, String password) async {
    final user = await _dbHelper.getUser(username, password);
    if (user != null) {
      // Simpan sesi ke Secure Storage jika valid
      await _storage.write(key: 'session_user', value: user.username);
    }
    return user;
  }

  Future<void> logout() async {
    await _storage.delete(key: 'session_user');
  }

  Future<String?> getSessionUser() async {
    return await _storage.read(key: 'session_user');
  }
}
