import 'package:flutter/material.dart';
import '../models/destinasi.dart';
import '../utils/app_colors.dart';
import '../widgets/destinasi_card.dart';
import 'detail_page.dart';

/// HALAMAN 2 - Daftar destinasi, bisa difilter berdasarkan kategori
/// dan/atau kata kunci pencarian dari Beranda.
class ListPage extends StatelessWidget {
  final List<Destinasi> semuaData;
  final String? kategori; // null = semua kategori
  final String? kataKunci; // null/kosong = tanpa pencarian

  const ListPage({
    super.key,
    required this.semuaData,
    this.kategori,
    this.kataKunci,
  });

  /// Menyaring data sesuai kategori & kata kunci.
  List<Destinasi> get _hasil {
    final q = (kataKunci ?? '').trim().toLowerCase();
    return semuaData.where((d) {
      final cocokKategori = kategori == null || d.kategori == kategori;
      final cocokKata = q.isEmpty ||
          d.nama.toLowerCase().contains(q) ||
          d.lokasi.toLowerCase().contains(q);
      return cocokKategori && cocokKata;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasil = _hasil;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.hijau,
        foregroundColor: Colors.white,
        title: Text(kategori == null ? 'Daftar Destinasi' : 'Wisata $kategori'),
      ),
      body: hasil.isEmpty
          ? const Center(child: Text('Destinasi tidak ditemukan.'))
          : Center(
              // Batasi lebar maksimum agar rapi di layar lebar (tablet)
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: hasil.length,
                  itemBuilder: (context, i) {
                    final d = hasil[i];
                    return DestinasiCard(
                      data: d,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailPage(data: d)),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
