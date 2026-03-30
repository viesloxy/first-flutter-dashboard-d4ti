import 'dart:convert';
import 'package:belajar_flutter/core/network/dio_client.dart';
import 'package:belajar_flutter/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MahasiswaAktifRepository {
  final DioClient _dioClient;

  MahasiswaAktifRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

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
      throw Exception(
        'Gagal memuat data mahasiswa aktif: ${response.statusCode}',
      );
    }
  }

  /// Mendapatkan daftar mahasiswa aktif menggunakan dio
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final Response response = await _dioClient.dio.get('/posts');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal memuat data mahasiswa aktif: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}