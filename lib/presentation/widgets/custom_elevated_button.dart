import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final String? fontFamily;
  final FontWeight fontWeight;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final bool isLoading;
  final double? iconSize;
  final EdgeInsetsGeometry? textPadding;
  final EdgeInsetsGeometry? iconPadding;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 16,
    this.fontFamily,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.width,
    this.height,
    this.isLoading = false,
    this.textPadding,
    this.iconSize,
    this.iconPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? SizedBox(
          height: fontSize + 4,
          width: fontSize + 4,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              textColor ?? Colors.white,
            ),
          ),
        )
            : icon != null
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: iconPadding ?? EdgeInsets.zero,
              child: Icon(icon, size: iconSize ?? 24),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight,
              ),
            ),
          ],
        )
            : Padding(
              padding: textPadding ?? EdgeInsets.zero,
              child: Text(
                        text,
                        style: TextStyle(
              fontSize: fontSize,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
                        ),
                      ),
            ),
      ),
    );
  }
}