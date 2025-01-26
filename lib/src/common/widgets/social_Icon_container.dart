 import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

Widget buildSocialIcon(
      String assetPath, VoidCallback onTap, BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme(context).surface.withOpacity(0.1),
          border:
              Border.all(color: colorScheme(context).surface.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(assetPath, height: 40),
      ),
    );
  }