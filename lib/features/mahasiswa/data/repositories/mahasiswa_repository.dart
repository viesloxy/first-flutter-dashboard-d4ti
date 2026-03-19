import 'dart:convert';
import 'package:belajar_flutter/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class MahasiswaRepository {
  final Dio _dio = Dio();

  /// Mendapatkan daftar mahasiswa menggunakan http
  Future<List<MahasiswaModel>> getMahasiswaListHttp() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data); // Debug: Tampilkan data yang sudah di-decode
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
    }
  }

  /// Mendapatkan daftar mahasiswa menggunakan dio
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/comments',
      options: Options(
        headers: {'Accept': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      print(data); // Debug: Tampilkan data yang sudah di-decode
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode} - ${response.data}');
      throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
    }
  }
}