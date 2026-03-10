import 'package:belajar_flutter/core/constants/app_constants.dart';
import 'package:belajar_flutter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:belajar_flutter/features/dashboard/presentation/pages/dashboard_page.dart';

// Run | Debug | Profile
void main() {
  // runApp(const MyApp());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: DashboardPage(),
    ); // MaterialApp
  }
}