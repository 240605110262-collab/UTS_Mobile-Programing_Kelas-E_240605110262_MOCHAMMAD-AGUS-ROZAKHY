import 'package:flutter/material.dart';

/// Menentukan ikon & warna untuk setiap kategori wisata.
class KategoriStyle {
  /// Daftar kategori yang tampil di beranda.
  static const List<String> daftar = ['Alam', 'Budaya', 'Kuliner', 'Edukasi'];

  static IconData ikon(String kategori) {
    switch (kategori) {
      case 'Alam':
        return Icons.terrain;
      case 'Budaya':
        return Icons.account_balance;
      case 'Kuliner':
        return Icons.restaurant;
      case 'Edukasi':
        return Icons.school;
      default:
        return Icons.place;
    }
  }

  static Color warna(String kategori) {
    switch (kategori) {
      case 'Alam':
        return const Color(0xFF2E9E5B);
      case 'Budaya':
        return const Color(0xFF8E5BB5);
      case 'Kuliner':
        return const Color(0xFFD9623B);
      case 'Edukasi':
        return const Color(0xFF2F7FD1);
      default:
        return Colors.grey;
    }
  }
}
