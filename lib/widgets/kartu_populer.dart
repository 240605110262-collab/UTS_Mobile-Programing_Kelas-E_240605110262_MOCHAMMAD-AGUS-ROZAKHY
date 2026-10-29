import 'package:flutter/material.dart';
import '../models/destinasi.dart';
import '../utils/kategori_style.dart';

/// Kartu besar bergradasi untuk daftar "Populer" (scroll horizontal).
class KartuPopuler extends StatelessWidget {
  final Destinasi data;
  final double lebar; // lebar kartu, dihitung dari ukuran layar (responsif)
  final VoidCallback onTap;

  const KartuPopuler({
    super.key,
    required this.data,
    required this.lebar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final warna = KategoriStyle.warna(data.kategori);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: lebar,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Gradasi dari warna kategori ke versi gelapnya
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [warna, Color.lerp(warna, Colors.black, 0.45)!],
          ),
        ),
        child: Stack(
          children: [
            // Ikon besar transparan sebagai dekorasi latar
            Positioned(
              right: -6,
              top: -6,
              child: Icon(KategoriStyle.ikon(data.kategori),
                  size: 90, color: Colors.white.withAlpha(60)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(data.kategori,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 11)),
                ),
                const SizedBox(height: 8),
                Text(data.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 3),
                    Text(data.rating.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12)),
                    const SizedBox(width: 10),
                    const Icon(Icons.place, size: 14, color: Colors.white70),
                    Expanded(
                      child: Text(data.lokasi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
