import 'package:flutter/material.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/pages/plugins/widget/select_times_for_day_widget.dart';

//ignore: must_be_immutable
class ScheduleCallSelectDayOfWeek extends StatefulWidget {
  const ScheduleCallSelectDayOfWeek({super.key});

  @override
  State<ScheduleCallSelectDayOfWeek> createState() =>
      _ScheduleCallSelectDayOfWeekState();
}

class _ScheduleCallSelectDayOfWeekState
    extends State<ScheduleCallSelectDayOfWeek> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScheduleData();
  }

  void getScheduleData() async {
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
  }

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
              child: ListView(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return daysWidget(context, weekday: weekday[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: weekday.length,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MaterialButton(
                onPressed: () {},
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

  Widget daysWidget(context, {required String weekday}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return SelectTimesForDayWidget(day: weekday);
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
            Text(
              weekday,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  List<String> weekday = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
}
