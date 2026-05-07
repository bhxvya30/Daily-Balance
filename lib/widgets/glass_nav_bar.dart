import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GlassNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: Container(
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xCC080808),
              border: Border(top: BorderSide(color: AppColors.borderTertiary, width: 0.5)),
            ),
            child: Row(
              children: [
                _buildTab(0, Icons.check_circle_outline, 'Today'),
                _buildTab(1, Icons.trending_up, 'Growth'),
                _buildTab(2, Icons.edit_note, 'Reflect'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final isActive = currentIndex == index;
    final color = isActive ? AppColors.textPrimary : AppColors.textTertiary;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
