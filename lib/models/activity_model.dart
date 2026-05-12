class ActivityModel {
  final String title;
  final String date;
  final String time;
  final String distance;
  final String duration;
  final String pace;
  final String calories;
  final String? note;

  ActivityModel({
    required this.title,
    required this.date,
    required this.time,
    required this.distance,
    required this.duration,
    required this.pace,
    required this.calories,
    this.note,
  });
}