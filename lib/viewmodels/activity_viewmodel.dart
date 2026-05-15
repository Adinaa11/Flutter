import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityViewModel extends ChangeNotifier {
  final List<ActivityModel> _activities = [
    ActivityModel(
      title: 'Lari Pagi',
      date: '20 Juni 2025',
      time: '06:15',
      distance: '20.0 km',
      duration: '2:00:00',
      pace: '6\'00"/km',
      calories: '1200',
      note: 'Lari pagi santai',
    ),

    ActivityModel(
      title: 'Easy Run',
      date: '18 Juni 2025',
      time: '06:45',
      distance: '10.2 km',
      duration: '1:02:30',
      pace: '6\'07"/km',
      calories: '600',
      note: 'Easy running',
    ),

    ActivityModel(
      title: 'Lari Sore',
      date: '16 Juni 2025',
      time: '16:30',
      distance: '7.5 km',
      duration: '45:20',
      pace: '6\'02"/km',
      calories: '400',
      note: 'Lari sore santai',
    ),
  ];

  List<ActivityModel> get activities => _activities;

  // ADD
  void addActivity(ActivityModel activity) {
    _activities.insert(0, activity);
    notifyListeners();
  }

  // DELETE
  void deleteActivity(ActivityModel activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  // UPDATE
  void updateActivity(ActivityModel oldActivity, ActivityModel newActivity) {
    final index = _activities.indexOf(oldActivity);

    if (index != -1) {
      _activities[index] = newActivity;
      notifyListeners();
    }
  }

  ActivityModel createActivity({
    required String title,
    required String date,
    required String time,
    required String distance,
    required String duration,
    required String pace,
    String? note,
  }) {
    return ActivityModel(
      title: title,
      date: date,
      time: time,
      distance: distance,
      duration: duration,
      pace: pace,
      calories: "0",
      note: note,
    );
  }

  // =======================
  // Statistik Dinamis
  // =======================
  Map<String, dynamic> computeStats() {
    double totalDistance = 0;
    int totalSeconds = 0;
    int totalCalories = 0;

    for (var act in _activities) {
      totalDistance += double.tryParse(act.distance.replaceAll(" km", "")) ?? 0;

      final parts = act.duration
          .split(":")
          .map((e) => int.tryParse(e) ?? 0)
          .toList();
      if (parts.length == 3) {
        totalSeconds += parts[0] * 3600 + parts[1] * 60 + parts[2];
      }

      totalCalories += int.tryParse(act.calories.replaceAll(".", "")) ?? 0;
    }

    String totalDuration =
        "${(totalSeconds ~/ 3600).toString().padLeft(2, '0')}:"
        "${((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0')}:"
        "${(totalSeconds % 60).toString().padLeft(2, '0')}";
    double pace = totalDistance > 0
        ? totalSeconds / 60 / totalDistance
        : 0; // menit per km

    return {
      "totalDistance": totalDistance.toStringAsFixed(1),
      "totalDuration": totalDuration,
      "averagePace": pace.toStringAsFixed(2),
      "totalCalories": totalCalories,
      "totalActivities": _activities.length,
    };
  }
}
