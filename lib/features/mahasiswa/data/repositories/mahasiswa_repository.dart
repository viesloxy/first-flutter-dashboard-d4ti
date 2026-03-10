import 'package:belajar_flutter/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  /// Mendapatkan daftar mahasiswa
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa
    return [
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '2021001',
        email: 'budi.santoso@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2021',
      ),
      MahasiswaModel(
        nama: 'Siti Rahayu',
        nim: '2021002',
        email: 'siti.rahayu@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2021',
      ),
      MahasiswaModel(
        nama: 'Ahmad Fauzi',
        nim: '2022001',
        email: 'ahmad.fauzi@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2022',
      ),
      MahasiswaModel(
        nama: 'Dewi Lestari',
        nim: '2022002',
        email: 'dewi.lestari@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2022',
      ),
      MahasiswaModel(
        nama: 'Rizky Pratama',
        nim: '2023001',
        email: 'rizky.pratama@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2023',
      ),
    ];
  }
}