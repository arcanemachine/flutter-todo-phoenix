import 'package:flutter/material.dart';
import 'package:flutter_todo_phoenix/styles.dart';

class _BaseWidgets {
  Widget disablableButton({
    isDisabled = true,
    dynamic onPressed,
    dynamic disabledOnPressed,
    Widget? child,
    Widget? disabledChild,
  }) {
    onPressed ??= () {};
    child ??= const Text("Disabled");

    if (!isDisabled) {
      return ElevatedButton(onPressed: onPressed, child: child);
    } else {
      return disabledButton(onPressed: disabledOnPressed, child: disabledChild);
    }
  }

  Widget disabledButton({dynamic onPressed, Widget? child}) {
    onPressed ??= () {};
    child ??= const Text("Disabled");

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colors.palette.secondary)),
      child: child,
    );
  }

  Widget emptyPlaceholder() {
    return const SizedBox.square(dimension: 0.0);
  }

  Widget loadingSpinner({double? size, Color? color}) {
    return SizedBox(
      height: size ?? 20.0,
      width: size ?? 20.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        color: color,
      ),
    );
  }
}

final baseWidgets = _BaseWidgets();
