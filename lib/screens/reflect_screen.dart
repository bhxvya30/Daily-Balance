import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../widgets/ambient_orbs.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_button.dart';
import '../widgets/mascot_widget.dart';

class ReflectScreen extends StatefulWidget {
  const ReflectScreen({Key? key}) : super(key: key);

  @override
  State<ReflectScreen> createState() => _ReflectScreenState();
}

class _ReflectScreenState extends State<ReflectScreen> {
  late TextEditingController _controller;

  final quotes = [
    {"quote": "The sun does not hurry, yet everything is accomplished.", "author": "Lao Tzu"},
    {"quote": "In the middle of every difficulty lies opportunity.", "author": "Albert Einstein"},
    {"quote": "He who conquers himself is the mightiest warrior.", "author": "Confucius"},
    {"quote": "Between stimulus and response there is a space.", "author": "Viktor Frankl"},
    {"quote": "You have power over your mind, not outside events.", "author": "Marcus Aurelius"},
    {"quote": "The secret of change is to focus all energy on building the new.", "author": "Socrates"},
    {"quote": "What you think, you become. What you feel, you attract.", "author": "Buddha"},
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AppStateProvider>();
      _controller.text = provider.draftText;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todayQuote = quotes[DateTime.now().weekday % quotes.length];

    return Consumer<AppStateProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                              Text("Quiet Reflection", style: AppTypography.h3),
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

                          // Quote Block
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                Text(
                                  '"',
                                  style: AppTypography.quote.copyWith(
                                    fontSize: 64,
                                    color: Colors.white.withOpacity(0.2),
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  todayQuote['quote']!,
                                  style: AppTypography.quote,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  todayQuote['author']!.toUpperCase(),
                                  style: AppTypography.quoteAuthor,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Mascot Card
                          GlassCard(
                            child: Center(
                              child: MascotWidget(
                                size: 60,
                                message: "Take a deep breath. You're doing wonderful today.",
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          Text("What are you feeling right now?", style: AppTypography.h2),
                          const SizedBox(height: 8),
                          Text(
                            "This is your private space. Be honest.",
                            style: AppTypography.body,
                          ),
                          const SizedBox(height: 24),

                          // Journal TextArea
                          GlassCard(
                            padding: const EdgeInsets.all(14),
                            child: TextField(
                              controller: _controller,
                              minLines: 5,
                              maxLines: null,
                              style: AppTypography.body,
                              cursorColor: Colors.white,
                              decoration: InputDecoration.collapsed(
                                hintText: "Write your thoughts here...",
                                hintStyle: AppTypography.body.copyWith(color: AppColors.textQuaternary),
                              ),
                              onChanged: (text) => provider.saveDraft(text),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: GhostButton(
                                  label: "Save Draft",
                                  onPressed: () {
                                    provider.saveDraft(_controller.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Draft saved"),
                                        margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: PrimaryButton(
                                  label: "Complete Reflection",
                                  onPressed: () {
                                    if (_controller.text.trim().isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Write something first"),
                                          margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
                                        ),
                                      );
                                    } else {
                                      provider.completeReflection(_controller.text);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Reflection saved ✓"),
                                          margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
                                        ),
                                      );
                                      _controller.clear();
                                    }
                                  },
                                ),
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
          ),
        );
      },
    );
  }
}
