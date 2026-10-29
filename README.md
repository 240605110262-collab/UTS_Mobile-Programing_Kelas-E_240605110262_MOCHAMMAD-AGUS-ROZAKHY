# Jelajah Malang

Aplikasi mobile (Flutter) panduan wisata Malang Raya — tugas UTS Mobile Programming.

## Tema & Tujuan
Membantu pengguna menemukan destinasi wisata (Alam, Budaya, Kuliner, Edukasi) di Malang Raya
beserta informasi lokasi, jam buka, tiket, dan fasilitas. Data masih **dummy** (JSON lokal).

## Halaman
| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_page.dart` | Sapaan, pencarian, kategori, destinasi populer & terbaru |
| Daftar | `lib/screens/list_page.dart` | Daftar destinasi, difilter kategori / kata kunci |
| Detail | `lib/screens/detail_page.dart` | Informasi lengkap, fasilitas, tombol favorit |

Navigasi memakai `Navigator.push` (Beranda -> Daftar -> Detail, dan Beranda -> Detail).

## Struktur Folder
```
lib/
  main.dart                  # titik masuk & tema
  models/destinasi.dart      # model data + fromJson
  services/destinasi_service.dart  # sumber data (JSON lokal, siap diganti API)
  screens/                   # 3 halaman
  widgets/                   # komponen kartu
  utils/                     # warna & gaya kategori
assets/data/destinasi.json   # data dummy
```

## Cara Menjalankan
1. Pasang Flutter SDK, lalu cek dengan `flutter doctor`.
2. Buat proyek: `flutter create jelajah_malang`
3. Salin `lib/`, `assets/`, dan `pubspec.yaml` dari repo ini ke proyek tersebut (timpa).
4. `flutter pub get`
5. Sambungkan HP (USB debugging aktif) lalu `flutter run`.

## Rencana Pengembangan
Ganti isi `DestinasiService.ambilSemua()` agar mengambil data dari API (package `http`).
