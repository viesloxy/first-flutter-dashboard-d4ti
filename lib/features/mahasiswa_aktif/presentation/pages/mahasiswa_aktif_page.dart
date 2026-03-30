import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:belajar_flutter/core/widgets/common_widgets.dart';
import 'package:belajar_flutter/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:belajar_flutter/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);
    final savedMahasiswaAktif = ref.watch(savedMahasiswaAktifProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaAktifNotifierProvider),
            tooltip: 'Refresh',
          ), // IconButton
        ],
      ), // AppBar
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // — Section: Data Tersimpan di SharedPreferences ——
          _SavedMahasiswaAktifSection(
            savedMahasiswaAktif: savedMahasiswaAktif,
            ref: ref,
          ),

          // — Section Title: Daftar Mahasiswa Aktif ————————————————
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa Aktif',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ), // Text
          ), // Padding

          // — Mahasiswa Aktif List ————————————————————————————
          Expanded(
            child: mahasiswaAktifState.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message:
                'Gagal memuat data mahasiswa aktif: ${error.toString()}',
                onRetry: () {
                  ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
                },
              ), // CustomErrorWidget
              data: (mahasiswaAktifList) => _MahasiswaAktifListWithSave(
                mahasiswaAktifList: mahasiswaAktifList,
                onRefresh: () => ref.invalidate(mahasiswaAktifNotifierProvider),
              ), // _MahasiswaAktifListWithSave
            ),
          ), // Expanded
        ],
      ), // Column
    ); // Scaffold
  }
}

// — Widget: Section data SharedPreferences ————————————————————
class _SavedMahasiswaAktifSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedMahasiswaAktif;
  final WidgetRef ref;

  const _SavedMahasiswaAktifSection({
    required this.savedMahasiswaAktif,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan tombol hapus semua
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text(
                'Data Tersimpan di Local Storage',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ), // Text
              const Spacer(),
              savedMahasiswaAktif.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                  onPressed: () async {
                    await ref
                        .read(mahasiswaAktifNotifierProvider.notifier)
                        .clearSavedMahasiswaAktif();
                    ref.invalidate(savedMahasiswaAktifProvider);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Semua data tersimpan dihapus'),
                        ), // SnackBar
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.delete_sweep_outlined,
                    size: 14,
                    color: Colors.red,
                  ), // Icon
                  label: const Text(
                    'Hapus Semua',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ), // Text
                ) // TextButton.icon
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ), // Row
          const SizedBox(height: 8),

          // Content
          savedMahasiswaAktif.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text(
              'Gagal membaca data tersimpan',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ), // Text
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ), // BoxDecoration
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.grey.shade400,
                      ), // Icon
                      const SizedBox(width: 8),
                      Text(
                        'Belum ada data. Tap ikon 💾 untuk menyimpan.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ), // TextStyle
                      ), // Text
                    ],
                  ), // Row
                ); // Container
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ), // BoxDecoration
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: Colors.green.shade100,
                    indent: 12,
                    endIndent: 12,
                  ), // Divider
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.green.shade100,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ), // TextStyle
                        ), // Text
                      ), // CircleAvatar
                      title: Text(
                        user['username'] ?? '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}',
                        style: const TextStyle(fontSize: 11),
                      ), // Text
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.red,
                        ), // Icon
                        onPressed: () async {
                          await ref
                              .read(mahasiswaAktifNotifierProvider.notifier)
                              .removeSavedMahasiswaAktif(
                            user['user_id'] ?? '',
                          );
                          ref.invalidate(savedMahasiswaAktifProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${user['username']} dihapus',
                                ),
                              ), // SnackBar
                            );
                          }
                        },
                      ), // IconButton
                    ); // ListTile
                  },
                ), // ListView.separated
              ); // Container
            },
          ),
        ],
      ), // Column
    ); // Padding
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return isoString;
    }
  }
}

// — Widget: List mahasiswa aktif dengan tombol save ————————————————————
class _MahasiswaAktifListWithSave extends ConsumerWidget {
  final List<MahasiswaAktifModel> mahasiswaAktifList;
  final VoidCallback onRefresh;

  const _MahasiswaAktifListWithSave({
    required this.mahasiswaAktifList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: mahasiswaAktifList.length,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemBuilder: (context, index) {
          final mahasiswaAktif = mahasiswaAktifList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${mahasiswaAktif.id}')),
              title: Text(
                mahasiswaAktif.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'User ID: ${mahasiswaAktif.userId}\n${mahasiswaAktif.body}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ), // Text
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save, size: 18),
                tooltip: 'Simpan mahasiswa aktif ini',
                onPressed: () async {
                  await ref
                      .read(mahasiswaAktifNotifierProvider.notifier)
                      .saveSelectedMahasiswaAktif(mahasiswaAktif);
                  ref.invalidate(savedMahasiswaAktifProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${mahasiswaAktif.title} berhasil disimpan ke local storage',
                        ),
                      ), // SnackBar
                    );
                  }
                },
              ), // IconButton
            ), // ListTile
          ); // Card
        },
      ), // ListView.builder
    ); // RefreshIndicator
  }
}