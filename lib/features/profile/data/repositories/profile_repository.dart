import 'package:belajar_flutter/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  /// Mendapatkan data profile
  Future<ProfileModel> getProfile() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy profile
    return ProfileModel(
      nama: 'Admin D4TI',
      nip: '198001012010011001',
      email: 'admin.d4ti@example.com',
      jurusan: 'Teknik Informatika',
      jabatan: 'Administrator',
      noTelp: '081234567890',
    );
  }
}