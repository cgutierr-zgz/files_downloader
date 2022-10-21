import 'package:flutter/material.dart';

/// {@template custom_snackbar}
/// A custom snackbar with two constructors:
/// [CustomSnackbar] and [CustomSnackbar.error].
///
/// Example:
/// ```dart
/// CustomSnackbar(
///   message: 'My message',
///   prefixIcon: Icons.abc,
///   onPressed: () {},
/// );
///
/// CustomSnackbar.error(
///   message: 'My Error',
///   onPressed: () {},
///   // prefixIcon is set by default to Icons.error
/// );
/// ```
/// {@endtemplate}

class CustomSnackbar extends StatelessWidget {
  /// {@macro custom_snackbar}
  const CustomSnackbar({
    super.key,
    required this.message,
    this.prefixIcon,
    this.onPressed,
  }) : backgroundColor = Colors.blueAccent;

  /// {@macro custom_snackbar}
  const CustomSnackbar.error({
    super.key,
    required this.message,
    this.onPressed,
  })  : prefixIcon = Icons.error,
        backgroundColor = Colors.red;

  final IconData? prefixIcon;
  final Color backgroundColor;
  final String message;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(prefixIcon, color: Colors.white),
                const SizedBox(width: 6)
              ],
              Expanded(
                child: Text(
                  message,
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          if (onPressed != null) _actions(context)
        ],
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            onPressed?.call();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: const Text('Accept'),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
