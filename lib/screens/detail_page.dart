import 'package:flutter/material.dart';
import '../models/destinasi.dart';
import '../utils/app_colors.dart';
import '../utils/kategori_style.dart';

/// HALAMAN 3 - Detail satu destinasi.
/// StatefulWidget karena ada tombol "favorit" yang berubah saat ditekan.
class DetailPage extends StatefulWidget {
  final Destinasi data;
  const DetailPage({super.key, required this.data});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _favorit = false;

  void _toggleFavorit() {
    setState(() => _favorit = !_favorit); // setState -> UI digambar ulang
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_favorit
            ? 'Ditambahkan ke favorit'
            : 'Dihapus dari favorit'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final warna = KategoriStyle.warna(d.kategori);

    // CustomScrollView + Sliver: header yang mengecil saat di-scroll
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            backgroundColor: AppColors.hijau,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: _toggleFavorit,
                icon: Icon(_favorit ? Icons.favorite : Icons.favorite_border),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(d.nama, style: const TextStyle(fontSize: 16)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [warna, Color.lerp(warna, Colors.black, 0.5)!],
                  ),
                ),
                child: Center(
                  child: Icon(KategoriStyle.ikon(d.kategori),
                      size: 96, color: Colors.white.withAlpha(160)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kartu informasi ringkas
                  Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _barisInfo(Icons.category, 'Kategori', d.kategori),
                          _barisInfo(Icons.place, 'Lokasi', d.lokasi),
                          _barisInfo(Icons.access_time, 'Jam Buka', d.jamBuka),
                          _barisInfo(
                              Icons.confirmation_number, 'Tiket', d.hargaFormat),
                          _barisInfo(
                              Icons.star, 'Rating', '${d.rating} / 5.0'),
                          _barisInfo(Icons.event, 'Ditambahkan',
                              d.tanggalFormat),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Tentang Destinasi',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(d.deskripsi,
                      style: const TextStyle(
                          height: 1.5, color: AppColors.teksGelap)),
                  const SizedBox(height: 20),
                  const Text('Fasilitas',
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // Wrap: chip otomatis pindah baris jika tidak muat
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: d.fasilitas
                        .map((f) => Chip(
                              label: Text(f),
                              backgroundColor: warna.withAlpha(35),
                              side: BorderSide.none,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Satu baris informasi: ikon + label + nilai.
  Widget _barisInfo(IconData ikon, String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, size: 20, color: AppColors.hijau),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(color: AppColors.teksRedup)),
          ),
          Expanded(
            child: Text(nilai,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
