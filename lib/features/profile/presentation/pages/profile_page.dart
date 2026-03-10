import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:belajar_flutter/core/constants/app_constants.dart';
import 'package:belajar_flutter/core/widgets/common_widgets.dart';
import 'package:belajar_flutter/features/profile/presentation/providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(profileNotifierProvider);
            },
            tooltip: 'Refresh',
          ), // IconButton
        ],
      ), // AppBar
      body: profileState.when(
        // State: Loading
        loading: () => const LoadingWidget(),

        // State: Error
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data profile: ${error.toString()}',
          onRetry: () {
            ref.read(profileNotifierProvider.notifier).refresh();
          },
        ), // CustomErrorWidget

        // State: menampilkan data profile
        data: (profile) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Profile
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppConstants.gradientPurple,
                    ), // LinearGradient
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ), // BorderRadius
                  ), // BoxDecoration
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 3,
                            ), // Border
                          ), // BoxDecoration
                          child: Center(
                            child: Text(
                              profile.nama.substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ), // TextStyle
                            ), // Text
                          ), // Center
                        ), // Container avatar
                        const SizedBox(height: 16),
                        // Nama
                        Text(
                          profile.nama,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ), // TextStyle
                        ), // Text
                        const SizedBox(height: 8),
                        // Jabatan
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ), // BoxDecoration
                          child: Text(
                            profile.jabatan,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ), // TextStyle
                          ), // Text
                        ), // Container jabatan
                      ],
                    ), // Column
                  ), // Padding
                ), // Container header

                // Info Detail
                Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informasi Detail',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ), // TextStyle
                      ), // Text
                      const SizedBox(height: 16),

                      // Info Cards
                      _buildInfoCard(
                        icon: Icons.badge_outlined,
                        label: 'NIP',
                        value: profile.nip,
                        gradientColors: AppConstants.gradientPurple,
                      ),
                      _buildInfoCard(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: profile.email,
                        gradientColors: AppConstants.gradientPink,
                      ),
                      _buildInfoCard(
                        icon: Icons.school_outlined,
                        label: 'Jurusan',
                        value: profile.jurusan,
                        gradientColors: AppConstants.gradientBlue,
                      ),
                      _buildInfoCard(
                        icon: Icons.work_outline_rounded,
                        label: 'Jabatan',
                        value: profile.jabatan,
                        gradientColors: AppConstants.gradientGreen,
                      ),
                      _buildInfoCard(
                        icon: Icons.phone_outlined,
                        label: 'No. Telepon',
                        value: profile.noTelp,
                        gradientColors: AppConstants.gradientPurple,
                      ),
                    ],
                  ), // Column
                ), // Padding
              ],
            ), // Column
          ); // SingleChildScrollView
        },
      ),
    ); // Scaffold
  }

  // Build info card widget
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required List<Color> gradientColors,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ), // BoxShadow
        ],
        border: Border.all(
          color: gradientColors[0].withOpacity(0.1),
          width: 1,
        ), // Border
      ), // BoxDecoration
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ), // LinearGradient
              borderRadius: BorderRadius.circular(12),
            ), // BoxDecoration
            child: Icon(icon, color: Colors.white, size: 22), // Icon
          ), // Container icon
          const SizedBox(width: 16),
          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ), // TextStyle
                ), // Text label
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ), // TextStyle
                ), // Text value
              ],
            ), // Column
          ), // Expanded
        ],
      ), // Row
    ); // Container
  }
}