import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:belajar_flutter/core/services/local_storage_service.dart';
import 'package:belajar_flutter/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:belajar_flutter/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

// Repository Provider
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
}); // Provider

// LocalStorageService Provider
final mahasiswaLocalStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
}); // Provider

// — Provider semua data mahasiswa yang disimpan ————————————————
final savedMahasiswaProvider = FutureProvider<List<Map<String, String>>>((
    ref,
    ) async {
  final storage = ref.watch(mahasiswaLocalStorageProvider);
  return storage.getSavedMahasiswa(); // pakai method khusus mahasiswa
});

// StateNotifier untuk mengelola state mahasiswa
class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  /// Load data mahasiswa dalam bentuk list
  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh data mahasiswa dalam bentuk list
  Future<void> refresh() async {
    await loadMahasiswaList();
  }

  /// Simpan mahasiswa yang dipilih ke local storage
  Future<void> saveSelectedMahasiswa(MahasiswaModel mahasiswa) async {
    await _storage.addMahasiswaToSavedList( // pakai method khusus mahasiswa
      userId: mahasiswa.id.toString(),
      username: mahasiswa.name,
    );
  }

  /// Hapus mahasiswa tertentu dari list
  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedMahasiswa(userId); // pakai method khusus mahasiswa
  }

  /// Hapus semua mahasiswa dari list
  Future<void> clearSavedUsers() async {
    await _storage.clearSavedMahasiswa(); // pakai method khusus mahasiswa
  }
}

// Mahasiswa Notifier Provider
final mahasiswaNotifierProvider =
StateNotifierProvider.autoDispose<MahasiswaNotifier,
    AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(mahasiswaLocalStorageProvider);
  return MahasiswaNotifier(repository, storage);
});