import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/destinasi.dart';

/// Lapisan pengambil data (service).
///
/// Saat ini data dibaca dari file JSON lokal (assets).
/// Pada tahap berikutnya, CUKUP ganti isi fungsi [ambilSemua] agar
/// memanggil API, misalnya dengan package `http`:
///
///   final res = await http.get(Uri.parse('https://api.contoh.com/destinasi'));
///   final List data = jsonDecode(res.body);
///
/// Halaman-halaman (UI) tidak perlu diubah sama sekali.
class DestinasiService {
  static Future<List<Destinasi>> ambilSemua() async {
    // 1. Baca isi file JSON sebagai teks
    final teks = await rootBundle.loadString('assets/data/destinasi.json');
    // 2. Ubah teks menjadi List<dynamic>
    final List<dynamic> daftarMap = jsonDecode(teks) as List<dynamic>;
    // 3. Ubah tiap Map menjadi objek Destinasi
    return daftarMap
        .map((e) => Destinasi.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
