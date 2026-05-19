class UserModel {
  final int? id;
  final String username;
  final String password;

  UserModel({this.id, required this.username, required this.password});

  // Mengubah data dari Database (Map) menjadi Objek UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  // Mengubah Objek UserModel menjadi Map untuk disimpan ke Database
  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }
}
