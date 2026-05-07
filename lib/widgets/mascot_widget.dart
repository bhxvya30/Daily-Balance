import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import 'glass_card.dart';

class MascotWidget extends StatelessWidget {
  final double size;
  final String? message;

  const MascotWidget({
    Key? key,
    this.size = 80,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: _MascotPainter(),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Text(
                message!,
                style: AppTypography.body.copyWith(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]
      ],
    );
  }
}

class _MascotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..color = const Color(0x1AFFFFFF)
      ..style = PaintingStyle.fill;
    
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.width * 0.3),
    );
    canvas.drawRRect(rrect, bgPaint);

    final linePaint = Paint()
      ..color = const Color(0x99FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final eyePaint = Paint()
      ..color = const Color(0x99FFFFFF)
      ..style = PaintingStyle.fill;

    // Eyes
    canvas.drawCircle(Offset(size.width * 0.35, size.height * 0.45), 4, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.45), 4, eyePaint);

    // Smile
    final smilePath = Path();
    smilePath.moveTo(size.width * 0.4, size.height * 0.65);
    smilePath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.75,
      size.width * 0.6, size.height * 0.65,
    );
    canvas.drawPath(smilePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
