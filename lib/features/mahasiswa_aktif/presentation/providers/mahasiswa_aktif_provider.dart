import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:belajar_flutter/core/services/local_storage_service.dart';
import 'package:belajar_flutter/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:belajar_flutter/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

// Repository Provider
final mahasiswaAktifRepositoryProvider =
Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
}); // Provider

// LocalStorageService Provider
final mahasiswaAktifLocalStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
}); // Provider

// — Provider semua data mahasiswa aktif yang disimpan ————————————————
final savedMahasiswaAktifProvider =
FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(mahasiswaAktifLocalStorageProvider);
  return storage.getSavedMahasiswaAktif();
});

// Provider untuk membaca saved mahasiswa aktif dari local storage
final savedMahasiswaAktifUserProvider =
FutureProvider<Map<String, String?>>((ref) async {
  final storage = ref.watch(mahasiswaAktifLocalStorageProvider);
  final userId = await storage.getUserId();
  final username = await storage.getUsername();
  final token = await storage.getToken();
  return {'userId': userId, 'username': username, 'token': token};
});

// StateNotifier untuk mengelola state mahasiswa aktif
class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;
  final LocalStorageService _storage;

  MahasiswaAktifNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadMahasiswaAktifList();
  }

  /// Load data mahasiswa aktif dalam bentuk list
  Future<void> loadMahasiswaAktifList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh data mahasiswa aktif dalam bentuk list
  Future<void> refresh() async {
    await loadMahasiswaAktifList();
  }

  /// Simpan mahasiswa aktif yang dipilih ke local storage
  Future<void> saveSelectedMahasiswaAktif(
      MahasiswaAktifModel mahasiswaAktif,
      ) async {
    await _storage.addMahasiswaAktifToSavedList(
      userId: mahasiswaAktif.id.toString(),
      username: mahasiswaAktif.title,
    );
  }

  /// Hapus mahasiswa aktif tertentu dari list
  Future<void> removeSavedMahasiswaAktif(String userId) async {
    await _storage.removeSavedMahasiswaAktif(userId);
  }

  /// Hapus semua mahasiswa aktif dari list
  Future<void> clearSavedMahasiswaAktif() async {
    await _storage.clearSavedMahasiswaAktif();
  }
}

// Mahasiswa Aktif Notifier Provider
final mahasiswaAktifNotifierProvider =
StateNotifierProvider.autoDispose<MahasiswaAktifNotifier,
    AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  final repository = ref.watch(mahasiswaAktifRepositoryProvider);
  final storage = ref.watch(mahasiswaAktifLocalStorageProvider);
  return MahasiswaAktifNotifier(repository, storage);
});