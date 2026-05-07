import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../widgets/ambient_orbs.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';
import '../widgets/mascot_widget.dart';
import '../widgets/stat_card.dart';
import '../widgets/ritual_card.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppStateProvider>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quotes = [
      "Consistency is the quiet power that transforms intentions into identity.",
      "Every moment of resistance is a deposit into who you are becoming.",
      "Discipline is choosing between what you want now and what you want most.",
      "The strongest man is not the one who overcomes others, but himself.",
      "Urges are waves. You do not have to surf every one.",
      "Your future self is watching your choices right now.",
      "Each day clean is a brick in the foundation of a new life."
    ];
    final todayQuote = quotes[DateTime.now().weekday % quotes.length];

    return Consumer<AppStateProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              const AmbientOrbs(),
              SafeArea(
                child: SingleChildScrollView(
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
                            Text("Daily Balance", style: AppTypography.h3),
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
                        
                        // Hero Mascot
                        const MascotWidget(size: 100),
                        const SizedBox(height: 16),
                        Text("Daily Balance", style: AppTypography.hero, textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        Text(
                          "Your quiet space for intentional growth.",
                          style: AppTypography.body,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Current Focus
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("CURRENT FOCUS", style: AppTypography.label),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.glassSecondary,
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(color: AppColors.borderTertiary, width: 0.5),
                                    ),
                                    child: Text(
                                      provider.checkedInToday ? "Done ✓" : "Pending",
                                      style: AppTypography.badge.copyWith(
                                        color: provider.checkedInToday ? Colors.greenAccent.shade100 : AppColors.textTertiary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text("Today's Status", style: AppTypography.h2),
                              const SizedBox(height: 8),
                              Text(
                                "Take a moment to center yourself and acknowledge your progress today.",
                                style: AppTypography.body,
                              ),
                              const SizedBox(height: 24),
                              Opacity(
                                opacity: provider.checkedInToday ? 0.4 : 1.0,
                                child: PrimaryButton(
                                  label: provider.checkedInToday ? "Checked In ✓" : "Check-in",
                                  onPressed: () {
                                    if (!provider.checkedInToday) {
                                      provider.doCheckIn();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Streak extended! Keep going 🔥"),
                                          margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Stats
                        Row(
                          children: [
                            StatCard(
                              number: provider.streak,
                              label: "Days of Focus",
                              icon: Icons.local_fire_department,
                            ),
                            const SizedBox(width: 8),
                            StatCard(
                              number: provider.mindfulActs,
                              label: "Mindful Acts",
                              icon: Icons.self_improvement,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Active Rituals
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Active Rituals", style: AppTypography.h3),
                            Text("View All →", style: AppTypography.caption),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: const [
                              RitualCard(label: "Morning Breath", icon: Icons.air, isActive: true),
                              SizedBox(width: 12),
                              RitualCard(label: "Evening Read", icon: Icons.book_outlined, isActive: false),
                              SizedBox(width: 12),
                              RitualCard(label: "Cold Shower", icon: Icons.water_drop, isActive: false),
                              SizedBox(width: 12),
                              RitualCard(label: "Journaling", icon: Icons.edit_note, isActive: false),
                              SizedBox(width: 12),
                              RitualCard(label: "Meditation", icon: Icons.self_improvement, isActive: false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Growth Insight
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("GROWTH INSIGHT", style: AppTypography.label),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '"$todayQuote"',
                                      style: AppTypography.quote.copyWith(color: Colors.white70),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.psychology, color: AppColors.textTertiary, size: 24),
                                ],
                              ),
                            ],
                          ),
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
