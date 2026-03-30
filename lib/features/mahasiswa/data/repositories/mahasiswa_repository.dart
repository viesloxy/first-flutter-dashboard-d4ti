import 'dart:convert';
import 'package:belajar_flutter/core/network/dio_client.dart';
import 'package:belajar_flutter/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MahasiswaRepository {
  final DioClient _dioClient;

  MahasiswaRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

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
    try {
      final Response response = await _dioClient.dio.get('/comments');
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal memuat data mahasiswa: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}