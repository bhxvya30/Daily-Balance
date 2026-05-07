import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class RitualCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;

  const RitualCard({
    Key? key,
    required this.label,
    required this.icon,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.glassSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? AppColors.borderPrimary : AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.glassPrimary,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 24,
              color: isActive ? AppColors.textPrimary : AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTypography.label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
