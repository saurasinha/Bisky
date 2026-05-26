import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:barabar/src/theme.dart';
import 'package:barabar/src/utils.dart';

class ChakraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final R = size.width * 0.46;

    void ring(double r, Color col, double strokeW) {
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()
          ..color = col
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW,
      );
    }

    void spokes(int n, double r1, double r2, Color col) {
      final p = Paint()..color = col..strokeWidth = 0.7;
      for (var i = 0; i < n; i++) {
        final a = i * 2 * math.pi / n;
        canvas.drawLine(
          Offset(cx + r1 * math.cos(a), cy + r1 * math.sin(a)),
          Offset(cx + r2 * math.cos(a), cy + r2 * math.sin(a)),
          p,
        );
      }
    }

    void dots(int n, double r, Color col, double rad) {
      final p = Paint()..color = col;
      for (var i = 0; i < n; i++) {
        final a = i * 2 * math.pi / n;
        canvas.drawCircle(
          Offset(cx + r * math.cos(a), cy + r * math.sin(a)),
          rad,
          p,
        );
      }
    }

    ring(R, Color.fromRGBO(0, 0, 128, 0.07), 0.8);
    ring(R * 0.75, Color.fromRGBO(0, 0, 128, 0.05), 0.6);
    ring(R * 0.50, Color.fromRGBO(0, 0, 128, 0.04), 0.5);
    ring(R * 0.20, Color.fromRGBO(255, 140, 0, 0.07), 0.7);
    spokes(24, R * 0.20, R, Color.fromRGBO(0, 0, 128, 0.06));
    spokes(12, R * 0.50, R * 0.75, Color.fromRGBO(255, 140, 0, 0.05));
    dots(24, R, Color.fromRGBO(255, 140, 0, 0.10), 2.5);
    dots(12, R * 0.75, Color.fromRGBO(0, 185, 107, 0.08), 2.0);
  }

  @override
  bool shouldRepaint(_) => false;
}

class Tricolor extends StatelessWidget {
  final double h;
  const Tricolor({super.key, this.h = 3});

  @override
  Widget build(BuildContext ctx) => Row(children: [
        Expanded(child: Container(height: h, color: C.flagSaffron)),
        Expanded(child: Container(height: h, color: C.flagWhite)),
        Expanded(child: Container(height: h, color: C.flagGreen)),
      ]);
}

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext ctx) => Container(
        height: 54,
        color: C.adBg,
        child: Column(children: [
          Container(height: 0.5, color: C.borderLight),
          const Expanded(
            child: Center(
              child: Text('Advertisement',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF2E2E50),
                    letterSpacing: 0.5,
                  )),
            ),
          ),
        ]),
      );
}

class TricolorBottom extends StatelessWidget implements PreferredSizeWidget {
  const TricolorBottom({super.key});

  @override
  Widget build(BuildContext ctx) => const Tricolor(h: 3);

  @override
  Size get preferredSize => const Size.fromHeight(3);
}

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext ctx) => Row(children: [
        Container(
          width: 3,
          height: 12,
          decoration: BoxDecoration(
            color: C.saffron,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(
              fontSize: sp(ctx, 10),
              fontWeight: FontWeight.w700,
              color: C.textSecond,
              letterSpacing: 0.8,
            )),
      ]);
}

class HKField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData prefix;
  final TextInputType? keyboardType;

  const HKField({super.key, this.controller, required this.hint, required this.prefix, this.keyboardType});

  @override
  Widget build(BuildContext ctx) => TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: C.textPrimary, fontSize: sp(ctx, 14)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: C.textHint, fontSize: sp(ctx, 13)),
          filled: true,
          fillColor: C.card,
          prefixIcon: Icon(prefix, color: C.saffron, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: C.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: C.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: C.saffron, width: 1.5),
          ),
        ),
      );
}

class PrimaryBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const PrimaryBtn({super.key, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext ctx) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [C.saffron, C.saffronDim],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(
              color: Color(0x4DFF8C00),
              blurRadius: 18,
              offset: Offset(0, 7),
            )],
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                  fontSize: sp(ctx, 13),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
          ]),
        ),
      );
}

class SecondaryBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const SecondaryBtn({super.key, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext ctx) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: C.elevated,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: C.borderLight),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, color: C.saffron, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                  fontSize: sp(ctx, 13),
                  fontWeight: FontWeight.w600,
                  color: C.textPrimary,
                )),
          ]),
        ),
      );
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const StatCard({super.key, required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext ctx) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: C.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: C.border),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: color, size: 17),
            const SizedBox(height: 7),
            Text(value,
                style: TextStyle(
                  fontSize: sp(ctx, 16),
                  fontWeight: FontWeight.w800,
                  color: C.textPrimary,
                )),
            Text(label,
                style: TextStyle(
                  fontSize: sp(ctx, 9),
                  color: C.textSecond,
                )),
          ]),
        ),
      );
}

class NavTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const NavTab({super.key, required this.icon, required this.label, required this.active});

  @override
  Widget build(BuildContext ctx) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, color: active ? C.saffron : C.textHint, size: 22),
            const SizedBox(height: 3),
            Text(label,
                style: TextStyle(
                  fontSize: sp(ctx, 10),
                  color: active ? C.saffron : C.textHint,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                )),
          ]),
        ),
      );
}

class ColorDot extends StatelessWidget {
  final Color color;
  const ColorDot(this.color, {super.key});

  @override
  Widget build(BuildContext _) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
