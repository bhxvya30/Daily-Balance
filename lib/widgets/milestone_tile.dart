import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import 'glass_card.dart';

class MilestoneTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isUnlocked;
  final IconData icon;

  const MilestoneTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isUnlocked,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isUnlocked ? 1.0 : 0.45,
      child: GlassCard(
        glassColor: AppColors.glassPrimary,
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnlocked ? AppColors.milestoneUnlocked : AppColors.glassSecondary,
              ),
              alignment: Alignment.center,
              child: Icon(
                isUnlocked ? icon : Icons.lock_outline,
                size: 20,
                color: isUnlocked ? Colors.black : AppColors.textQuaternary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.buttonSecondary.copyWith(
                    color: isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
                  )),
                  Text(subtitle, style: AppTypography.caption),
                ],
              ),
            ),
            if (isUnlocked)
              const Icon(Icons.check, color: AppColors.textSecondary, size: 20)
            else
              const Icon(Icons.lock, color: AppColors.textQuaternary, size: 20),
          ],
        ),
      ),
    );
  }
}
