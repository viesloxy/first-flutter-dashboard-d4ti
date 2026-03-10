class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final String angkatan;
  final String semester;
  final String status;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    required this.angkatan,
    required this.semester,
    required this.status,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      angkatan: json['angkatan'] ?? '',
      semester: json['semester'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'angkatan': angkatan,
      'semester': semester,
      'status': status,
    };
  }
}