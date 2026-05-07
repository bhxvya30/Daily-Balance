import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';
import '../models/reflection_model.dart';

class AppStateProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();

  int    _streak          = 0;
  int    _mindfulActs     = 0;
  bool   _checkedInToday  = false;
  List<bool> _weeklyData  = List.filled(7, false);
  Map<String, bool> _milestones = {};
  double _consistency     = 0;
  List<ReflectionModel> _reflections = [];
  String _draftText       = '';

  int    get streak          => _streak;
  int    get mindfulActs     => _mindfulActs;
  bool   get checkedInToday  => _checkedInToday;
  List<bool> get weeklyData  => _weeklyData;
  Map<String, bool> get milestones => _milestones;
  double get consistency     => _consistency;
  List<ReflectionModel> get reflections => _reflections;
  String get draftText       => _draftText;

  Future<void> loadAll() async {
    _streak         = await _storage.getStreak();
    _mindfulActs    = await _storage.getMindfulActs();
    _checkedInToday = await _storage.hasCheckedInToday();
    _weeklyData     = await _storage.getWeeklyCheckIns();
    _milestones     = await _storage.getMilestones();
    _consistency    = await _storage.getConsistencyPercent();
    _reflections    = await _storage.getReflections();
    _draftText      = (await _storage.getDraft()) ?? '';
    notifyListeners();
  }

  Future<void> doCheckIn() async {
    _streak        = await _storage.doCheckIn();
    _checkedInToday = true;
    _mindfulActs   = await _storage.getMindfulActs();
    _weeklyData    = await _storage.getWeeklyCheckIns();
    _milestones    = await _storage.getMilestones();
    _consistency   = await _storage.getConsistencyPercent();
    notifyListeners();
  }

  Future<void> saveDraft(String content) async {
    _draftText = content;
    await _storage.saveDraft(content);
    notifyListeners();
  }

  Future<void> completeReflection(String content) async {
    await _storage.saveReflection(content);
    _reflections = await _storage.getReflections();
    _draftText   = '';
    notifyListeners();
  }
}
