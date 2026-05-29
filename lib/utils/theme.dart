import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  // ================= LIGHT THEME =================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        background: AppColors.background,
        surface: AppColors.cardBackground,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: AppColors.background,

      // ================= CARD THEME =================
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 3,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // ================= APP BAR =================
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),

      // ================= TEXT =================
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: const TextStyle(color: AppColors.textPrimary),
        bodyMedium: const TextStyle(color: AppColors.textSecondary),
        titleLarge: const TextStyle(color: AppColors.textPrimary),
      ),

      // ================= BUTTONS =================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 3,
        ),
      ),

      // ================= INPUT =================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.surfaceLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.surfaceLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  // ================= DARK THEME =================
  //   static ThemeData get darkTheme {
  //     return ThemeData(
  //       useMaterial3: true,

  //       colorScheme: ColorScheme.fromSeed(
  //         seedColor: AppColors.primary,
  //         primary: AppColors.primary,
  //         secondary: AppColors.accent,
  //         background: AppColors.darkBackground,
  //         surface: AppColors.darkCardBackground,
  //         brightness: Brightness.dark,
  //       ),

  //       scaffoldBackgroundColor: AppColors.darkBackground,

  //       // ================= CARD THEME =================
  //       cardTheme: CardThemeData(
  //         color: AppColors.darkCardBackground,
  //         elevation: 3,
  //         shadowColor: Colors.black54,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       ),

  //       // ================= APP BAR =================
  //       appBarTheme: AppBarTheme(
  //         backgroundColor: AppColors.darkBackground,
  //         elevation: 0,
  //         centerTitle: true,
  //         iconTheme: const IconThemeData(color: Colors.white),
  //         titleTextStyle: GoogleFonts.poppins(
  //           fontSize: 20,
  //           fontWeight: FontWeight.w700,
  //           color: AppColors.darkTextPrimary,
  //         ),
  //       ),

  //       // ================= TEXT =================
  //       textTheme: GoogleFonts.poppinsTextTheme().copyWith(
  //         bodyLarge: const TextStyle(color: AppColors.darkTextPrimary),
  //         bodyMedium: const TextStyle(color: AppColors.darkTextSecondary),
  //         titleLarge: const TextStyle(color: AppColors.darkTextPrimary),
  //       ),

  //       // ================= BUTTONS =================
  //       elevatedButtonTheme: ElevatedButtonThemeData(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: AppColors.primary,
  //           foregroundColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(14),
  //           ),
  //           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
  //           textStyle: GoogleFonts.poppins(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w600,
  //           ),
  //           elevation: 3,
  //         ),
  //       ),

  //       // ================= INPUT =================
  //       inputDecorationTheme: InputDecorationTheme(
  //         filled: true,
  //         fillColor: AppColors.darkCardBackground,
  //         contentPadding: const EdgeInsets.symmetric(
  //           horizontal: 16,
  //           vertical: 14,
  //         ),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(14),
  //           borderSide: const BorderSide(color: AppColors.darkSurface),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(14),
  //           borderSide: const BorderSide(color: AppColors.darkSurface),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(14),
  //           borderSide: const BorderSide(color: AppColors.primary, width: 2),
  //         ),
  //       ),
  //     );
  //   }
}
