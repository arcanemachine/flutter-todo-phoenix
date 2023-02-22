import 'dart:math';
import 'package:flutter/material.dart';

/* COLORS */
class _Colors {
  final palette = _Palette();

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}

class _Palette {
  final primary = const Color(0xFF257BFD);
  final secondary = const Color(0xFF5E656C);
  final accent = const Color(0xFF0A6BFD);
  final neutral = const Color(0xFF3B68AB);
  final base100 = const Color(0xFFF6F6FF);
  final info = const Color(0xFF97C0FE);
  final success = const Color(0xFF198754);
  final warning = const Color(0xFFFFC107);
  final error = const Color(0xFFDC3545);
}

final colors = _Colors();

// styles
class _Styles {
  get button => _Button();
  get colors => _Colors();
  // get text => _Text();
}

final styles = _Styles();

// styles.button
class _Button {
  final ButtonStyle elevatedLgPrimary = ElevatedButton.styleFrom(
    backgroundColor: colors.palette.primary,
    textStyle: const TextStyle(fontSize: 20.0),
    minimumSize: const Size(300, 50),
  );
  final ButtonStyle elevatedLgSecondary = ElevatedButton.styleFrom(
    backgroundColor: colors.palette.secondary,
    textStyle: const TextStyle(fontSize: 20.0),
    minimumSize: const Size(300, 50),
  );
}

// class _Text {
//   TextStyle italicIf(bool result) {
//     return result
//         ? const TextStyle(fontStyle: FontStyle.italic)
//         : const TextStyle();
//   }
// }
