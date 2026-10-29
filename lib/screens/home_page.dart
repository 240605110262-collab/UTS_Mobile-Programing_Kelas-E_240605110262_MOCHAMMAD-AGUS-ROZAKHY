import 'package:flutter/material.dart';
import '../models/destinasi.dart';
import '../services/destinasi_service.dart';
import '../utils/app_colors.dart';
import '../utils/kategori_style.dart';
import '../widgets/destinasi_card.dart';
import '../widgets/kartu_populer.dart';
import 'detail_page.dart';
import 'list_page.dart';

/// HALAMAN 1 - Beranda: sapaan, pencarian, kategori, populer, terbaru.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future disimpan di state agar data tidak dimuat ulang tiap rebuild
  late final Future<List<Destinasi>> _futureData;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureData = DestinasiService.ambilSemua();
  }

  @override
  void dispose() {
    _searchCtrl.dispose(); // bersihkan controller agar tidak bocor memori
    super.dispose();
  }

  /// Pindah ke halaman daftar. [kategori]/[kataKunci] opsional sebagai filter.
  void _bukaDaftar(List<Destinasi> semua,
      {String? kategori, String? kataKunci}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ListPage(
            semuaData: semua, kategori: kategori, kataKunci: kataKunci),
      ),
    );
  }

  /// Pindah ke halaman detail.
  void _bukaDetail(Destinasi d) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(data: d)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FutureBuilder: menampilkan UI sesuai status pemuatan data
      body: FutureBuilder<List<Destinasi>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
          }
          return _buildIsi(snapshot.data!);
        },
      ),
    );
  }

  Widget _buildIsi(List<Destinasi> semua) {
    // Populer = urut rating tertinggi, ambil 5
    final populer = [...semua]..sort((a, b) => b.rating.compareTo(a.rating));
    // Terbaru = urut tanggal terbaru, ambil 4
    final terbaru = [...semua]
      ..sort((a, b) => b.tanggalDitambahkan.compareTo(a.tanggalDitambahkan));

    // MediaQuery: ukuran layar, dipakai agar kartu proporsional (responsif)
    final lebarLayar = MediaQuery.of(context).size.width;
    final lebarKartu = (lebarLayar * 0.7).clamp(220.0, 320.0);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(semua),
          const SizedBox(height: 20),

          // ---- Kategori ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: KategoriStyle.daftar
                  .map((k) => _itemKategori(k, semua))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),

          // ---- Populer (scroll horizontal) ----
          _judulSeksi('Destinasi Populer'),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: populer.length > 5 ? 5 : populer.length,
              itemBuilder: (_, i) => KartuPopuler(
                data: populer[i],
                lebar: lebarKartu,
                onTap: () => _bukaDetail(populer[i]),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ---- Terbaru ----
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _judulSeksi('Destinasi Terbaru'),
                TextButton(
                  onPressed: () => _bukaDaftar(semua),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: terbaru
                  .take(4)
                  .map((d) => DestinasiCard(data: d, onTap: () => _bukaDetail(d)))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Header hijau berisi sapaan + kolom pencarian.
  Widget _buildHeader(List<Destinasi> semua) {
    return Container(
      width: double.infinity,
      // padding atas memperhitungkan status bar (poni/notch) HP
      padding: EdgeInsets.fromLTRB(
          20, MediaQuery.of(context).padding.top + 20, 20, 28),
      decoration: const BoxDecoration(
        color: AppColors.hijau,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Selamat Datang',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Mau jelajah ke mana di Malang Raya hari ini?',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 16),
          TextField(
            controller: _searchCtrl,
            textInputAction: TextInputAction.search,
            // onSubmitted: dipanggil saat tombol "cari" di keyboard ditekan
            onSubmitted: (v) => _bukaDaftar(semua, kataKunci: v),
            decoration: InputDecoration(
              hintText: 'Cari nama atau lokasi wisata',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Satu ikon kategori (kotak berwarna + label).
  Widget _itemKategori(String kategori, List<Destinasi> semua) {
    final warna = KategoriStyle.warna(kategori);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _bukaDaftar(semua, kategori: kategori),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: warna.withAlpha(45),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(KategoriStyle.ikon(kategori), color: warna, size: 30),
          ),
          const SizedBox(height: 6),
          Text(kategori,
              style: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _judulSeksi(String teks) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Text(teks,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.teksGelap)),
    );
  }
}
