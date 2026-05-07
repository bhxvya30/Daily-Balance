class ReflectionModel {
  final String id;
  final DateTime date;
  final String content;
  final bool isDraft;

  ReflectionModel({
    required this.id,
    required this.date,
    required this.content,
    this.isDraft = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'content': content,
    'isDraft': isDraft,
  };

  factory ReflectionModel.fromJson(Map<String, dynamic> json) =>
    ReflectionModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      content: json['content'],
      isDraft: json['isDraft'] ?? false,
    );
}
