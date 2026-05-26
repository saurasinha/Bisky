import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class C {
  static const bg          = Color(0xFFF7F8FA);
  static const card        = Color(0xFFFFFFFF);
  static const elevated    = Color(0xFFF2F4F7);
  static const saffron     = Color(0xFFFF8C00);
  static const saffronDim  = Color(0xFFCC6000);
  static const saffronBg   = Color(0x20FF8C00);
  static const emerald     = Color(0xFF00B96B);
  static const emeraldBg   = Color(0x1800B96B);
  static const danger      = Color(0xFFFF4757);
  static const flagSaffron = Color(0xFFFF9933);
  static const flagWhite   = Color(0xFFF5F0E8);
  static const flagGreen   = Color(0xFF138808);
  static const flagNavy    = Color(0xFF000080);
  static const textPrimary = Color(0xFF0B0B18);
  static const textSecond  = Color(0xFF6A6A90);
  static const textHint    = Color(0xFF9AA0B2);
  static const border      = Color(0xFFE6E9F0);
  static const borderLight = Color(0xFFF0F2F5);
  static const panel       = Color(0xFFFFF4D9);
  static const adBg        = Color(0xFFF8F9FB);
}

final ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: C.bg,
  colorScheme: const ColorScheme.light(
    primary: C.saffron,
    secondary: C.emerald,
    surface: C.card,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme,
  ),
  useMaterial3: true,
);
