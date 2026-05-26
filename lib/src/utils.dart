import 'package:flutter/material.dart';
import 'package:barabar/src/theme.dart';

double sw(BuildContext c) => MediaQuery.of(c).size.width;

double sp(BuildContext c, double b) =>
    (b * sw(c) / 375).clamp(b * 0.82, b * 1.22);

double kPad(BuildContext c) => sw(c) * 0.054;

void showSnack(BuildContext ctx, String msg, {bool error = false}) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(msg, style: const TextStyle(fontSize: 13)),
    backgroundColor: error ? C.danger : C.emerald,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 2),
  ));
}

void goTo(BuildContext ctx, Widget screen) =>
    Navigator.push(ctx, MaterialPageRoute(builder: (_) => screen));
