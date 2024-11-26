import 'dart:convert';

List<ScheduleUserModel> scheduleUserModelFromJson(String str) =>
    List<ScheduleUserModel>.from(
        json.decode(str).map((x) => ScheduleUserModel.fromJson(x)));

String scheduleUserModelToJson(List<ScheduleUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleUserModel {
  List<TimeSlot> timeSlots;
  String pluginId;
  final String? learnLanguage;
  final int? timezone;

  ScheduleUserModel({
    required this.timeSlots,
    required this.pluginId,
    this.learnLanguage,
    this.timezone,
  });

  factory ScheduleUserModel.fromJson(Map<String, dynamic> json) =>
      ScheduleUserModel(
        timeSlots: List<TimeSlot>.from(
            json["timeSlots"].map((x) => TimeSlot.fromJson(x))),
        pluginId: json["pluginId"],
        learnLanguage: json["learnLanguage"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "timeSlots": List<dynamic>.from(timeSlots.map((x) => x.toJson())),
        "pluginId": pluginId,
        "learnLanguage": learnLanguage,
        "timezone": timezone,
      };
}

class TimeSlot {
  int dayOfWeek;
  int hour;

  TimeSlot({
    required this.dayOfWeek,
    required this.hour,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        dayOfWeek: json["dayOfWeek"],
        hour: json["hour"],
      );

  Map<String, dynamic> toJson() => {
        "dayOfWeek": dayOfWeek,
        "hour": hour,
      };
}
