class CheckInModel {
  final DateTime date;
  final int mindfulActsDelta;

  CheckInModel({required this.date, this.mindfulActsDelta = 1});

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'mindfulActsDelta': mindfulActsDelta,
  };

  factory CheckInModel.fromJson(Map<String, dynamic> json) =>
    CheckInModel(
      date: DateTime.parse(json['date']),
      mindfulActsDelta: json['mindfulActsDelta'] ?? 1,
    );
}
