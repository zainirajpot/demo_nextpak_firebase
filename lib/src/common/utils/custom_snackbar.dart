import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../constants/global_variables.dart';

void showSnackbar({
  VoidCallback? onPressed,
  required String message,
  IconData? icon,
  Color? backgroundColor,
  String? label,
  bool isError = false,
  bool closeButton = false,
  double overflowThreshold = 1.0,
  bool longActionLabel = false,
  bool floatingType = true,
  bool longLength = false,
}) {
  final appTheme = AppTheme.instance.lightTheme;
  final SnackBarAction? snackBarAction = label != null
      ? SnackBarAction(
          label: longActionLabel ? "" : label,
          onPressed: onPressed ?? () {},
        )
      : null;

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          isError
              ? icon ?? Icons.warning_amber_rounded
              : Icons.done_all_rounded,
          size: 25,
          color: appTheme.colorScheme.surface,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            message,
            textAlign: TextAlign.start,
            style: appTheme.textTheme.bodyMedium?.copyWith(
              color: appTheme.colorScheme.surface,
            ),
          ),
        ),
      ],
    ),
    showCloseIcon: closeButton,
    closeIconColor: appTheme.colorScheme.surface,
    behavior: floatingType ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    action: snackBarAction,
    duration: const Duration(seconds: 5),
    backgroundColor: isError
        ? appTheme.colorScheme.error
        : backgroundColor ?? const Color(0xFF424242),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    actionOverflowThreshold: overflowThreshold,
  );

  scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
