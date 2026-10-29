import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'utils/app_colors.dart';

/// Titik masuk aplikasi. Flutter selalu mulai menjalankan dari fungsi main().
void main() {
  runApp(const JelajahMalangApp());
}

/// Widget akar (root) aplikasi: mengatur tema global & halaman pertama.
class JelajahMalangApp extends StatelessWidget {
  const JelajahMalangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jelajah Malang',
      debugShowCheckedModeBanner: false, // sembunyikan pita "DEBUG"
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.hijau),
        scaffoldBackgroundColor: AppColors.krem,
      ),
      home: const HomePage(), // halaman pertama = Beranda
    );
  }
}
