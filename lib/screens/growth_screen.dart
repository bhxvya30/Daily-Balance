import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_state_provider.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../widgets/ambient_orbs.dart';
import '../widgets/glass_card.dart';
import '../widgets/mascot_widget.dart';
import '../widgets/milestone_tile.dart';
import '../widgets/stat_card.dart';

class GrowthScreen extends StatefulWidget {
  const GrowthScreen({Key? key}) : super(key: key);

  @override
  State<GrowthScreen> createState() => _GrowthScreenState();
}

class _GrowthScreenState extends State<GrowthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppStateProvider>().loadAll();
    });
  }

  String _getMotivationalTitle(int streak) {
    if (streak == 0) return "Begin your journey";
    if (streak < 3) return "Building momentum";
    if (streak < 7) return "Stay the course";
    if (streak < 30) return "Keep standing tall";
    return "You are unstoppable";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, provider, child) {
        int checkedDays = provider.weeklyData.where((v) => v).length;
        int avgScore = ((checkedDays / 7) * 100).round();

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              const AmbientOrbs(),
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        // App Bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.glassPrimary,
                                border: Border.all(color: AppColors.borderSecondary, width: 0.5),
                              ),
                              child: const Icon(Icons.person_outline, color: AppColors.textTertiary, size: 16),
                            ),
                            Text("Growth Path", style: AppTypography.h3),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.glassPrimary,
                                border: Border.all(color: AppColors.borderSecondary, width: 0.5),
                              ),
                              child: const Icon(Icons.settings_outlined, color: AppColors.textTertiary, size: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Hero Section
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderPrimary, width: 0.5),
                          ),
                          alignment: Alignment.center,
                          child: const MascotWidget(size: 80),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getMotivationalTitle(provider.streak),
                          style: AppTypography.h1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your resilience builds a stronger foundation every day.",
                          style: AppTypography.body,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Weekly Trend
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("WEEKLY TREND", style: AppTypography.label),
                                      const SizedBox(height: 4),
                                      Text("Steady Progress", style: AppTypography.h3),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("$avgScore%", style: AppTypography.statNumber),
                                      Text("Avg. Score", style: AppTypography.label),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 100,
                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 1,
                                    minY: 0,
                                    gridData: FlGridData(show: false),
                                    borderData: FlBorderData(show: false),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            const labels = ["M", "T", "W", "T", "F", "S", "S"];
                                            if (value.toInt() >= 0 && value.toInt() < labels.length) {
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Text(labels[value.toInt()], style: AppTypography.label),
                                              );
                                            }
                                            return const Text('');
                                          },
                                        ),
                                      ),
                                    ),
                                    barGroups: List.generate(7, (i) {
                                      final isChecked = provider.weeklyData[i];
                                      return BarChartGroupData(
                                        x: i,
                                        barRods: [
                                          BarChartRodData(
                                            toY: 1,
                                            color: isChecked ? AppColors.barActive : AppColors.barInactive,
                                            width: 14,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              topRight: Radius.circular(4),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Milestones
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Milestones Achieved", style: AppTypography.h3),
                            Text("View All", style: AppTypography.caption),
                          ],
                        ),
                        const SizedBox(height: 16),
                        MilestoneTile(
                          title: "First 24 Hours",
                          subtitle: "Completed on day 1",
                          isUnlocked: provider.milestones['first_24h'] ?? false,
                          icon: Icons.timer_outlined,
                        ),
                        const SizedBox(height: 12),
                        MilestoneTile(
                          title: "1 Week Strong",
                          subtitle: "7 days of focus",
                          isUnlocked: provider.milestones['one_week'] ?? false,
                          icon: Icons.fitness_center_outlined,
                        ),
                        const SizedBox(height: 12),
                        MilestoneTile(
                          title: "Monthly Anchor",
                          subtitle: "${30 - provider.streak > 0 ? 30 - provider.streak : 0} days remaining",
                          isUnlocked: provider.milestones['one_month'] ?? false,
                          icon: Icons.anchor_outlined,
                        ),
                        const SizedBox(height: 12),
                        MilestoneTile(
                          title: "90 Day Master",
                          subtitle: "The identity shift",
                          isUnlocked: provider.milestones['three_months'] ?? false,
                          icon: Icons.emoji_events_outlined,
                        ),
                        const SizedBox(height: 24),

                        // Stats
                        Row(
                          children: [
                            StatCard(
                              number: provider.streak,
                              label: "Current Streak",
                              icon: Icons.local_fire_department,
                            ),
                            const SizedBox(width: 8),
                            StatCard(
                              number: provider.consistency.round(),
                              label: "Consistency %",
                              icon: Icons.favorite_border,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
