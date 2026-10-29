/// Model data untuk satu destinasi wisata.
///
/// Kelas ini sengaja dibuat dengan constructor `fromJson` supaya
/// nanti saat memakai API, bentuk data dari server (JSON) tinggal
/// diubah menjadi objek Dart dengan cara yang SAMA seperti JSON lokal.
class Destinasi {
  final int id;
  final String nama;
  final String kategori;
  final String lokasi;
  final String deskripsi;
  final double rating;
  final int hargaTiket; // dalam Rupiah, 0 = gratis
  final String jamBuka;
  final DateTime tanggalDitambahkan;
  final List<String> fasilitas;

  const Destinasi({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.lokasi,
    required this.deskripsi,
    required this.rating,
    required this.hargaTiket,
    required this.jamBuka,
    required this.tanggalDitambahkan,
    required this.fasilitas,
  });

  /// Membuat objek Destinasi dari Map hasil `jsonDecode`.
  factory Destinasi.fromJson(Map<String, dynamic> json) {
    return Destinasi(
      id: json['id'] as int,
      nama: json['nama'] as String,
      kategori: json['kategori'] as String,
      lokasi: json['lokasi'] as String,
      deskripsi: json['deskripsi'] as String,
      // `num` dipakai agar aman baik data berupa 4 maupun 4.5
      rating: (json['rating'] as num).toDouble(),
      hargaTiket: json['harga_tiket'] as int,
      jamBuka: json['jam_buka'] as String,
      tanggalDitambahkan: DateTime.parse(json['tanggal_ditambahkan'] as String),
      fasilitas: List<String>.from(json['fasilitas'] as List),
    );
  }

  /// Contoh: 35000 -> "Rp 35.000", 0 -> "Gratis"
  String get hargaFormat {
    if (hargaTiket == 0) return 'Gratis';
    final dgTitik = hargaTiket.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (m) => '.',
        );
    return 'Rp $dgTitik';
  }

  /// Contoh: 2025-09-14 -> "14 September 2025"
  String get tanggalFormat {
    const bulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final t = tanggalDitambahkan;
    return '${t.day} ${bulan[t.month - 1]} ${t.year}';
  }
}
