import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
              color: theme.colorScheme.onSurfaceVariant.withAlpha(50)),
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.onInverseSurface),
      child: Image.asset(
        imagePath,
        height: 72,
      ),
    );
  }
}
