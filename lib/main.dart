import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'state/app_state.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const SpendSyncApp(),
    ),
  );
}

class SpendSyncApp extends StatelessWidget {
  const SpendSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpendSync',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.accent,
          surface: AppColors.cardBackground,
          error: AppColors.error,
          onPrimary: AppColors.primary,
          onSecondary: AppColors.primary,
          onSurface: AppColors.textPrimary,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
            .copyWith(
              titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w700),
              titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              bodyLarge: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              bodyMedium: GoogleFonts.poppins(fontWeight: FontWeight.w400),
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          iconTheme: IconThemeData(color: AppColors.accent),
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: AppColors.surfaceLight.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceLight,
          labelStyle: const TextStyle(color: AppColors.textLight),
          floatingLabelStyle: const TextStyle(color: AppColors.accent),
          hintStyle: const TextStyle(color: AppColors.textLight),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.surfaceLight,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.surfaceLight,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.accent, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
