import 'dart:convert';

class ScheduleCallModel {
  int dayOfWeek;
  String dayName;
  List<CallTimeModel> callTimeModels = [];

  ScheduleCallModel(
      {required this.dayOfWeek,
      required this.dayName,
      required this.callTimeModels});
}

class CallTimeModel {
  String timeString;
  int hours;
  int minute;

  CallTimeModel(
      {required this.timeString, required this.hours, required this.minute});
}

List timeSlotsModelToJson(List<TimeSlotsModel> data) => List<dynamic>.from(data.map((x) => x.toJson()));


class TimeSlotsModel {
  int dayOfWeek;
  int hour;

  TimeSlotsModel({
    required this.dayOfWeek,
    required this.hour,
  });

  Map<String, dynamic> toJson() => {
    "dayOfWeek": dayOfWeek,
    "hour": hour,
  };
}
