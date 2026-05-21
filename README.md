# sqflrvrpd


<!-- _class: lead -->
# Implementasi SQFLITE, Flutter Secure Storage, dan Riverpod dengan pendekatan MVVM di Flutter
**Menggabungkan Sqflite, Secure Storage, & Riverpod 2.0 (Generator)**

---

## 1. Arsitektur MVVM di Aplikasi Kita
**Bagaimana Komponen Saling Berkomunikasi?**

- **Model:** Representasi blueprint data (`UserModel`).
- **Data (Repository):** Lapisan yang mengurus dari mana data berasal (Database Sqflite & Secure Storage).
- **ViewModel (Riverpod):** Fungsi utama aplikasi. Mengambil data dari Repository, memprosesnya, dan mengubah nilainya menjadi *State* (Kondisi).
- **View (UI):** Antarmuka pengguna yang pasif. Hanya memantau ViewModel dan merender layar jika ada perubahan.

<!-- Note:
Di arsitektur ini, UI (View) tidak boleh tahu cara menulis ke database. UI hanya boleh mengeluh ke ViewModel, lalu ViewModel yang akan menyuruh Repository untuk menyimpan datanya. Ini membuat kode kita sangat rapi dan mudah diuji.
-->

---

## 2. Struktur Folder Proyek
**Pemisahan Berdasarkan Tanggung Jawab (Separation of Concerns)**

```text
lib/
 ├── models/
 │    └── user_model.dart       (Struktur data User)
 ├── data/
 │    ├── database_helper.dart  (Logika mentah Sqflite)
 │    └── auth_repository.dart  (Jembatan Sqflite & Secure Storage)
 ├── viewmodels/
 │    └── auth_viewmodel.dart   (Pengendali state dengan Riverpod)
 └── views/
      ├── auth_wrapper.dart     (Pemantau sesi login)
      └── login_view.dart, home_view.dart, register_view.dart
