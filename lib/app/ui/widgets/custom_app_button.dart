import 'package:flutter/material.dart';

class CustomElevatedIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Icon icon;
  const CustomElevatedIconButton(
      {super.key, this.onPressed, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onLongPress: () {},
      onPressed: onPressed,
      autofocus: false,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size(135, 60),
      ),
      iconAlignment: IconAlignment.start,
      label: label,
      icon: icon,
    );
  }
}
