import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import 'glass_card.dart';

class StatCard extends StatelessWidget {
  final int number;
  final String label;
  final IconData icon;

  const StatCard({
    Key? key,
    required this.number,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        glassColor: AppColors.glassSecondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glassTertiary,
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: AppColors.textSecondary, size: 20),
            ),
            const SizedBox(height: 16),
            Text(number.toString(), style: AppTypography.statNumber),
            const SizedBox(height: 4),
            Text(label.toUpperCase(), style: AppTypography.label),
          ],
        ),
      ),
    );
  }
}
