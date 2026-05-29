import 'package:flutter/material.dart';

class AppColors {
  // ================= CORE THEME COLORS =================
  static const Color primary = Color(0xFF002147);       // Oxford Blue
  static const Color primaryDark = Color(0xFF001229);   // Deep Dark Blue
  static const Color primaryLight = Color(0xFF0D3E74);  // Medium Oxford Blue
  static const Color accent = Color(0xFFFFCB05);        // Maize Yellow
  static const Color accentDark = Color(0xFFD4A800);    // Darker Maize (for shadows)

  // ================= BACKGROUND / SURFACE COLORS =================
  static const Color background = Color(0xFF0B1426);        // Deep Navy (lighter than before)
  static const Color cardBackground = Color(0xFF142238);    // Visible card navy
  static const Color surfaceLight = Color(0xFF1E3352);      // Lighter navy surface

  // ================= TEXT STYLE COLORS =================
  static const Color textPrimary = Color(0xFFFFFFFF);       // Pure White — max contrast
  static const Color textSecondary = Color(0xFFD0DCF0);     // Light blue-white
  static const Color textLight = Color(0xFF8FA8CC);         // Muted blue-gray
  static const Color textWhite = Color(0xFFFFFFFF);

  // ================= STATUS COLORS =================
  static const Color success = Color(0xFF10B981); // Emerald Green
  static const Color error = Color(0xFFF43F5E);   // Coral/Rose Red
  static const Color warning = Color(0xFFF59E0B); // Amber Warning
  static const Color info = Color(0xFF3B82F6);    // Dodger Blue

  // ================= CATEGORY COLORS =================
  static const Color food = Color(0xFFF87171);           // Pastel Red
  static const Color transport = Color(0xFF38BDF8);      // Light Blue
  static const Color shopping = Color(0xFFFBBF24);       // Yellow
  static const Color bills = Color(0xFF818CF8);          // Indigo
  static const Color entertainment = Color(0xFFF472B6);  // Pink
  static const Color others = Color(0xFFA7F3D0);         // Mint

  // ================= GRADIENTS =================
  // Primary card gradient: Oxford Blue shades
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0D3E74), Color(0xFF002147)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Accent / CTA gradient: Maize Yellow
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFFD740), Color(0xFFFFCB05)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF0D3E74), Color(0xFF0B1426)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkPrimaryGradient = LinearGradient(
    colors: [
      Color(0xFF002147),
      Color(0xFF0D3E74),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
