import 'package:flutter/material.dart';
import '../models/destinasi.dart';
import '../utils/app_colors.dart';
import '../utils/kategori_style.dart';

/// Kartu satu baris untuk daftar destinasi (dipakai di Beranda & Daftar).
class DestinasiCard extends StatelessWidget {
  final Destinasi data;
  final VoidCallback onTap; // aksi saat kartu ditekan

  const DestinasiCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final warna = KategoriStyle.warna(data.kategori);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Kotak ikon di sebelah kiri
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: warna.withAlpha(40),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(KategoriStyle.ikon(data.kategori),
                    color: warna, size: 32),
              ),
              const SizedBox(width: 12),
              // Expanded: agar teks mengisi sisa ruang & tidak overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nama,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.teksGelap),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${data.kategori} • ${data.lokasi}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.teksRedup),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 14, color: AppColors.aksen),
                        const SizedBox(width: 2),
                        Text(data.rating.toString(),
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 8),
                        Text(data.hargaFormat,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.teksRedup)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Tombol "Lihat Info" (hanya tampilan; tap ditangani InkWell)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.aksen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Lihat Info',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
