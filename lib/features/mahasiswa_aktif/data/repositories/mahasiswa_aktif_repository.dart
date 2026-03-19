import 'dart:convert';
import 'package:belajar_flutter/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MahasiswaAktifRepository {
  final Dio _dio = Dio();

  /// Mendapatkan daftar mahasiswa aktif menggunakan http
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifListHttp() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data); // Debug: Tampilkan data yang sudah di-decode
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal memuat data mahasiswa aktif: ${response.statusCode}');
    }
  }

  /// Mendapatkan daftar mahasiswa aktif menggunakan dio
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/posts',
      options: Options(
        headers: {'Accept': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      print(data); // Debug: Tampilkan data yang sudah di-decode
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.data}');
      throw Exception('Gagal memuat data mahasiswa aktif: ${response.statusCode}');
    }
  }
}