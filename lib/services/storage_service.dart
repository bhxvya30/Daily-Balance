import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/check_in_model.dart';
import '../models/reflection_model.dart';

class StorageService {
  static const _keyStreak          = 'streak_count';
  static const _keyLastCheckIn     = 'last_check_in_date';
  static const _keyCheckInHistory  = 'check_in_history';
  static const _keyMindfulActs     = 'mindful_acts_count';
  static const _keyReflectionDraft = 'reflection_draft';
  static const _keyReflections     = 'reflections';

  // ─── STREAK ────────────────────────────────────────────

  Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await _recalculateStreakIfNeeded(prefs);
    return prefs.getInt(_keyStreak) ?? 0;
  }

  Future<void> _recalculateStreakIfNeeded(SharedPreferences prefs) async {
    final lastDateStr = prefs.getString(_keyLastCheckIn);
    if (lastDateStr == null) return;
    final lastDate = DateTime.parse(lastDateStr);
    final today = DateTime.now();
    final diff = today.difference(lastDate).inDays;
    // If more than 1 day missed, reset streak
    if (diff > 1) {
      await prefs.setInt(_keyStreak, 0);
    }
  }

  Future<bool> hasCheckedInToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString(_keyLastCheckIn);
    if (lastDateStr == null) return false;
    final last = DateTime.parse(lastDateStr);
    final now  = DateTime.now();
    return last.year == now.year &&
           last.month == now.month &&
           last.day == now.day;
  }

  Future<int> doCheckIn() async {
    final prefs    = await SharedPreferences.getInstance();
    final already  = await hasCheckedInToday();
    if (already) return prefs.getInt(_keyStreak) ?? 0;

    // Increment streak
    final current = prefs.getInt(_keyStreak) ?? 0;
    final newStreak = current + 1;
    await prefs.setInt(_keyStreak, newStreak);
    await prefs.setString(_keyLastCheckIn, DateTime.now().toIso8601String());

    // Record in history
    final history = await getCheckInHistory();
    history.add(CheckInModel(date: DateTime.now()));
    await _saveCheckInHistory(prefs, history);

    // Increment mindful acts
    final acts = prefs.getInt(_keyMindfulActs) ?? 0;
    await prefs.setInt(_keyMindfulActs, acts + 1);

    return newStreak;
  }

  // ─── CHECK-IN HISTORY ──────────────────────────────────

  Future<List<CheckInModel>> getCheckInHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyCheckInHistory);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => CheckInModel.fromJson(e)).toList();
  }

  Future<void> _saveCheckInHistory(
      SharedPreferences prefs, List<CheckInModel> history) async {
    await prefs.setString(
      _keyCheckInHistory,
      jsonEncode(history.map((e) => e.toJson()).toList()),
    );
  }

  // Returns true/false for each of the last 7 days (oldest first)
  Future<List<bool>> getWeeklyCheckIns() async {
    final history = await getCheckInHistory();
    final checkedDates = history.map((e) {
      final d = e.date;
      return '${d.year}-${d.month}-${d.day}';
    }).toSet();

    final now = DateTime.now();
    return List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      final key = '${day.year}-${day.month}-${day.day}';
      return checkedDates.contains(key);
    });
  }

  // ─── MINDFUL ACTS ──────────────────────────────────────

  Future<int> getMindfulActs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyMindfulActs) ?? 0;
  }

  // ─── MILESTONES ────────────────────────────────────────

  Future<Map<String, bool>> getMilestones() async {
    final streak = await getStreak();
    return {
      'first_24h':   streak >= 1,
      'one_week':    streak >= 7,
      'one_month':   streak >= 30,
      'three_months': streak >= 90,
    };
  }

  Future<double> getConsistencyPercent() async {
    final weekly = await getWeeklyCheckIns();
    final done = weekly.where((v) => v).length;
    return (done / 7) * 100;
  }

  // ─── REFLECTIONS ───────────────────────────────────────

  Future<void> saveDraft(String content) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyReflectionDraft, content);
  }

  Future<String?> getDraft() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyReflectionDraft);
  }

  Future<void> saveReflection(String content) async {
    final prefs = await SharedPreferences.getInstance();
    final list  = await getReflections();
    list.add(ReflectionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      content: content,
      isDraft: false,
    ));
    await prefs.setString(
      _keyReflections,
      jsonEncode(list.map((e) => e.toJson()).toList()),
    );
    // Clear draft after saving
    await prefs.remove(_keyReflectionDraft);
  }

  Future<List<ReflectionModel>> getReflections() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyReflections);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => ReflectionModel.fromJson(e)).toList();
  }

  // ─── RESET (for testing) ───────────────────────────────

  Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
