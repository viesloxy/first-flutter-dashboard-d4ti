class ProfileModel {
  final String nama;
  final String nip;
  final String email;
  final String jurusan;
  final String jabatan;
  final String noTelp;

  ProfileModel({
    required this.nama,
    required this.nip,
    required this.email,
    required this.jurusan,
    required this.jabatan,
    required this.noTelp,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      nip: json['nip'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      jabatan: json['jabatan'] ?? '',
      noTelp: json['noTelp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nip': nip,
      'email': email,
      'jurusan': jurusan,
      'jabatan': jabatan,
      'noTelp': noTelp,
    };
  }
}