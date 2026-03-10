import 'package:belajar_flutter/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  /// Mendapatkan daftar mahasiswa aktif
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa aktif
    return [
      MahasiswaAktifModel(
        nama: 'Budi Santoso',
        nim: '2021001',
        email: 'budi.santoso@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2021',
        semester: '7',
        status: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Siti Rahayu',
        nim: '2021002',
        email: 'siti.rahayu@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2021',
        semester: '7',
        status: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Ahmad Fauzi',
        nim: '2022001',
        email: 'ahmad.fauzi@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2022',
        semester: '5',
        status: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Dewi Lestari',
        nim: '2022002',
        email: 'dewi.lestari@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2022',
        semester: '5',
        status: 'Aktif',
      ),
      MahasiswaAktifModel(
        nama: 'Rizky Pratama',
        nim: '2023001',
        email: 'rizky.pratama@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2023',
        semester: '3',
        status: 'Aktif',
      ),
    ];
  }
}