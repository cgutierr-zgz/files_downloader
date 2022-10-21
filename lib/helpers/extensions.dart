import 'package:file_downloader/downloader/downloader.dart';
import 'package:flutter/material.dart';

extension ConstrainerX on Widget {
  Widget constrain([double maxWidth = 500]) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: this,
    );
  }
}

extension BuildContextExtensionsX on BuildContext {
  /// Grants access to [ThemeData] based on given context
  ///
  /// Usage:
  /// ```dart
  /// final theme = context.theme;
  /// ```
  ///
  /// {@macro l10n_extension}
  ThemeData get theme => Theme.of(this);

  /// Shows a snackbar with the given message and hides the other snackbars.
  ///
  /// Usage:
  /// ```dart
  /// context.showSnackbar('Very good message');
  /// ```
  ///
  /// {@macro l10n_extension}
  void showSnackbar(
    String message, {
    bool error = false,
    IconData? prefixIcon,
    void Function()? onPressed,
  }) =>
      ScaffoldMessenger.of(this)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: error
                ? CustomSnackbar.error(message: message, onPressed: onPressed)
                : CustomSnackbar(
                    message: message,
                    prefixIcon: prefixIcon,
                    onPressed: onPressed,
                  ),
          ),
        );
}
