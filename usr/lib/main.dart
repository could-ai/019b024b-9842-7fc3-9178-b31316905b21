import 'package:couldai_user_app/providers/app_provider.dart';
import 'package:couldai_user_app/providers/vibe_provider.dart';
import 'package:couldai_user_app/providers/datapool_provider.dart';
import 'package:couldai_user_app/providers/hoster_provider.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/screens/hoster_suite_screen.dart';
import 'package:couldai_user_app/screens/vibe_planner_screen.dart';
import 'package:couldai_user_app/screens/settings_screen.dart';
import 'package:couldai_user_app/screens/datapool_manager_screen.dart';
import 'package:couldai_user_app/screens/project_maker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => HosterProvider()),
        ChangeNotifierProvider(create: (_) => VibeProvider()),
        ChangeNotifierProvider(create: (_) => DatapoolProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouldAI Hoster Suite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/hoster': (context) => const HosterSuiteScreen(),
        '/vibe': (context) => const VibePlannerScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/datapool': (context) => const DatapoolManagerScreen(),
        '/project-maker': (context) => const ProjectMakerScreen(),
      },
    );
  }
}