import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double? textSize;
  final double? letterSpacing;
  final double? borderRadius;
  final double? elevation;
  final Color? textColor;
  final FontWeight? fontWeight;
  final List<Color>? gradientColors;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final bool isIconRight;
  final Color? borderColor; // Added border color parameter
  final double? borderWidth; // Added border width parameter

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.elevation,
    this.textColor,
    this.fontWeight,
    this.textSize,
    this.letterSpacing,
    this.borderRadius,
    this.gradientColors,
    this.color,
    this.padding,
    this.width,
    this.height,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.isIconRight = false,
    this.borderColor, // Initialize border color parameter
    this.borderWidth, // Initialize border width parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      width: width ?? MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
            side: borderColor != null
                ? BorderSide(
                    color: borderColor!,
                    width: borderWidth ?? 1.0,
                  )
                : BorderSide.none,
          ),
          elevation: elevation ?? 0,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: color ?? colorScheme(context).primary,
            gradient: color == null
                ? LinearGradient(
                    colors: gradientColors ??
                        [
                          Color(0xFF8E2DE2), Color.fromARGB(166, 166, 3, 117),
                          Color.fromARGB(154, 212, 132, 4),
                        ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius ?? 6),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                    width: borderWidth ?? 1.0,
                  )
                : null,
          ),
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: isIconRight
                ? _buildTextWithIcon(context)
                : _buildIconWithText(context),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: iconSize ?? 20,
            color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor ?? colorScheme(context).onPrimary,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontSize: textSize ?? 15,
            letterSpacing: letterSpacing ?? 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildTextWithIcon(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor ?? colorScheme(context).onPrimary,
            fontWeight: fontWeight ?? FontWeight.w600,
            fontSize: textSize ?? 14,
          ),
        ),
        if (icon != null) ...[
          const SizedBox(width: 8),
          Icon(
            icon,
            size: iconSize ?? 20,
            color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ],
    );
  }
}
