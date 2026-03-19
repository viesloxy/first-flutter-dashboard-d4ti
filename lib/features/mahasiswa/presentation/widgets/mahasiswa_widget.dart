import 'package:flutter/material.dart';
import 'package:belajar_flutter/core/constants/app_constants.dart';
import 'package:belajar_flutter/features/mahasiswa/data/models/mahasiswa_model.dart';

class ModernMahasiswaCard extends StatefulWidget {
  final MahasiswaModel mahasiswa;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernMahasiswaCard({
    Key? key,
    required this.mahasiswa,
    this.onTap,
    this.gradientColors,
  }) : super(key: key);

  @override
  State<ModernMahasiswaCard> createState() => _ModernMahasiswaCardState();
}

class _ModernMahasiswaCardState extends State<ModernMahasiswaCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    ); // AnimationController
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        widget.gradientColors ??
            [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ];

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, gradientColors[0].withOpacity(0.05)],
            ), // LinearGradient
            borderRadius: BorderRadius.circular(20),
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
            ), // Border.all
          ), // BoxDecoration
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar with Gradient
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: gradientColors,
                    ), // LinearGradient
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ), // BoxShadow
                    ],
                  ), // BoxDecoration
                  child: Center(
                    child: Text(
                      widget.mahasiswa.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ), // TextStyle
                    ), // Text
                  ), // Center
                ), // Container
                const SizedBox(width: 16),

                // Mahasiswa Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.mahasiswa.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ), // TextStyle
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ), // Text
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.email_outlined,
                        widget.mahasiswa.email,
                      ),
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        Icons.comment_outlined,
                        widget.mahasiswa.body,
                      ),
                      const SizedBox(height: 4),
                      _buildInfoRow(
                        Icons.tag_outlined,
                        'Post ID: ${widget.mahasiswa.postId} | ID: ${widget.mahasiswa.id}',
                      ),
                    ],
                  ), // Column
                ), // Expanded

                // Arrow Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: gradientColors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ), // BoxDecoration
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: gradientColors[0],
                  ), // Icon
                ), // Container
              ],
            ), // Row
          ), // Padding
        ), // Container
      ), // ScaleTransition
    ); // GestureDetector
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ), // Text
        ), // Expanded
      ],
    ); // Row
  }
}

class MahasiswaEmptyState extends StatelessWidget {
  final VoidCallback? onRefresh;

  const MahasiswaEmptyState({Key? key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ), // BoxDecoration
            child: Icon(
              Icons.people_outline_rounded,
              size: 64,
              color: Colors.grey[400],
            ), // Icon
          ), // Container
          const SizedBox(height: 24),
          Text(
            'Tidak ada data mahasiswa',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ), // TextStyle
          ), // Text
          const SizedBox(height: 8),
          Text(
            'Belum ada mahasiswa yang terdaftar',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ), // Text
          if (onRefresh != null) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ), // EdgeInsets.symmetric
              ), // ElevatedButton.styleFrom
            ), // ElevatedButton.icon
          ],
        ],
      ), // Column
    ); // Center
  }
}

class MahasiswaListView extends StatelessWidget {
  final List<MahasiswaModel> mahasiswaList;
  final VoidCallback onRefresh;
  final bool useModernCard;

  const MahasiswaListView({
    Key? key,
    required this.mahasiswaList,
    required this.onRefresh,
    this.useModernCard = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mahasiswaList.isEmpty) {
      return MahasiswaEmptyState(onRefresh: onRefresh);
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaList[index];
          final gradientColors =
          AppConstants.dashboardGradients[index %
              AppConstants.dashboardGradients.length];

          if (useModernCard) {
            return ModernMahasiswaCard(
              mahasiswa: mahasiswa,
              gradientColors: gradientColors,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Detail: ${mahasiswa.name}'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ), // SnackBar
                );
              },
            ); // ModernMahasiswaCard
          } else {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(mahasiswa.name),
                subtitle: Text(mahasiswa.email),
              ),
            );
          }
        },
      ), // ListView.builder
    ); // RefreshIndicator
  }
}