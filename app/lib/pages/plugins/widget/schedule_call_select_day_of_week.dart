import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/backend/schema/plugin.dart';
import 'package:friend_private/pages/plugins/widget/model/schedule_call.dart';
import 'package:friend_private/pages/plugins/widget/model/schedule_user.dart';
import 'package:friend_private/pages/plugins/widget/select_times_for_day_widget.dart';

class ScheduleCallSelectDayOfWeek extends StatefulWidget {
  final Plugin plugin;

  const ScheduleCallSelectDayOfWeek({super.key, required this.plugin});

  @override
  State<ScheduleCallSelectDayOfWeek> createState() =>
      _ScheduleCallSelectDayOfWeekState();
}

class _ScheduleCallSelectDayOfWeekState
    extends State<ScheduleCallSelectDayOfWeek> {
  @override
  void initState() {
    super.initState();
    getScheduleCallsApi();
  }

  /*void getScheduleData() async {
    debugPrint(
        " SharedPreferencesUtil().authToken :- ${SharedPreferencesUtil().authToken}");

    var mainHeaders = {
      "accept": "application/json",
      "Authorization": await getAuthHeader()
    };
    var response = await makeApiCall(
      url:
          'https://agiens-backend-662477620892.us-central1.run.app/api/v1/schedule/user',
      method: 'GET',
      headers: mainHeaders,
      body: "",
    );

    debugPrint("response response :- ${response?.body}");
    debugPrint("response response :- ${response?.statusCode}");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          title: const Text("Select Days of the Week"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SelectTimesForDayWidget(
                            day: weekday[index].dayName,
                            selectedList: weekday[index].callTimeModels,
                            onSave: (list) {
                              debugPrint(
                                  "SelectTimesForDayWidget -> ${list.length}");
                              weekday[index].callTimeModels.clear();
                              weekday[index].callTimeModels.addAll(list);
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      color: Colors.grey.shade900,
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  weekday[index].dayName,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: List.generate(
                                    weekday[index].callTimeModels.length,
                                    (ind) => Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(weekday[index]
                                          .callTimeModels[ind]
                                          .timeString),
                                    ),
                                  ),
                                ),
                                if (weekday[index].callTimeModels.isNotEmpty)
                                  const SizedBox(height: 5),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: weekday.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MaterialButton(
                onPressed: () async {
                  bool isSuccessful = await setScheduleCallsApi(context);
                  if (isSuccessful) {
                    Navigator.of(context).pop();
                  }
                },
                minWidth: double.maxFinite,
                color: Colors.deepPurple,
                child: const Text("Schedule"),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<ScheduleCallModel> weekday = [
    ScheduleCallModel(dayOfWeek: 1, dayName: "Monday", callTimeModels: []),
    ScheduleCallModel(dayOfWeek: 2, dayName: "Tuesday", callTimeModels: []),
    ScheduleCallModel(dayOfWeek: 3, dayName: "Wednesday", callTimeModels: []),
    ScheduleCallModel(dayOfWeek: 4, dayName: "Thursday", callTimeModels: []),
    ScheduleCallModel(dayOfWeek: 5, dayName: "Friday", callTimeModels: []),
    ScheduleCallModel(dayOfWeek: 6, dayName: "Saturday", callTimeModels: []),
    ScheduleCallModel(dayOfWeek: 0, dayName: "Sunday", callTimeModels: []),
  ];

  Future<bool> setScheduleCallsApi(BuildContext context) async {
    var mainHeaders = {
      "accept": "application/json",
      "Authorization": await getAuthHeader()
    };

    List<TimeSlotsModel> timeSlotsModels = [];
    for (int i = 0; i < weekday.length; i++) {
      for (int j = 0; j < weekday[i].callTimeModels.length; j++) {
        timeSlotsModels.add(TimeSlotsModel(
            dayOfWeek: weekday[i].dayOfWeek,
            hour: weekday[i].callTimeModels[j].hours));
      }
    }

    Map<String, dynamic> passDate = {
      "pluginId": widget.plugin.id,
      "timeSlots": timeSlotsModelToJson(timeSlotsModels)
    };

    var response = await makeApiCall(
      url:
          'https://agiens-backend-662477620892.us-central1.run.app/api/v1/schedule',
      method: 'POST',
      headers: mainHeaders,
      body: json.encode(passDate),
    );

    debugPrint("verifyOTPApi response :- ${response?.body}");
    debugPrint("verifyOTPApi response :- ${response?.statusCode}");
    if (response!.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Something went wrong please try again!'),
      duration: Duration(seconds: 1),
    ));
    return false;
  }

  Future<void> getScheduleCallsApi() async {
    var mainHeaders = {
      "accept": "application/json",
      "Authorization": await getAuthHeader()
    };

    var response = await makeApiCall(
        url:
            'https://agiens-backend-662477620892.us-central1.run.app/api/v1/schedule/user',
        method: 'GET',
        headers: mainHeaders,
        body: "");

    debugPrint("getScheduleCallsApi response :- ${response?.body}");
    debugPrint("getScheduleCallsApi response :- ${response?.statusCode}");
    if (response!.statusCode == 200) {
      List<ScheduleUserModel> scheduleUserModels =
          scheduleUserModelFromJson(response.body);
      for (int i = 0; i < scheduleUserModels.length; i++) {
        if (scheduleUserModels[i].pluginId == widget.plugin.id) {
          for (int j = 0; j < scheduleUserModels[i].timeSlots.length; j++) {
            for (int k = 0; k < weekday.length; k++) {
              if (scheduleUserModels[i].timeSlots[j].dayOfWeek ==
                  weekday[k].dayOfWeek) {
                weekday[k].callTimeModels.add(CallTimeModel(
                    hours: scheduleUserModels[i].timeSlots[j].hour,
                    minute: 0,
                    timeString:
                        "${scheduleUserModels[i].timeSlots[j].hour.toString().padLeft(2, '0')}:00"));
              }
            }
          }
        }
      }
      setState(() {});
    }
  }
}
