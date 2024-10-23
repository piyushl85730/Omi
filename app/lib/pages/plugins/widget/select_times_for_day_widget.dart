import 'package:flutter/material.dart';
import 'package:friend_private/pages/plugins/widget/model/schedule_call.dart';

class SelectTimesForDayWidget extends StatefulWidget {
  final String day;
  final List<CallTimeModel> selectedList;
  final Function(List<CallTimeModel>) onSave;

  const SelectTimesForDayWidget(
      {super.key,
      required this.day,
      required this.selectedList,
      required this.onSave});

  @override
  State<SelectTimesForDayWidget> createState() =>
      _SelectTimesForDayWidgetState();
}

class _SelectTimesForDayWidgetState extends State<SelectTimesForDayWidget> {
  @override
  void initState() {
    super.initState();
    selectedList.addAll(widget.selectedList);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context: context),
    );
  }

  Widget contentBox({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.maxFinite,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).dialogBackgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                "Select Times for ${widget.day}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Builder(builder: (context) {
              if (selectedList.isEmpty) {
                return const SizedBox();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Selected times",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedList = [];
                          setState(() {});
                        },
                        child: Image.asset(
                          "assets/images/clear.webp",
                          color: Colors.white,
                          height: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      selectedList.length,
                      (index) => selectTimeWidget(
                          list: selectedList[index], isFromSelectedTime: true),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }),
            Builder(builder: (context) {
              List<CallTimeModel> listSelectTime = manageSelectTime();
              if (listSelectTime.isEmpty) {
                return const SizedBox();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select times",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      listSelectTime.length,
                      (index) => selectTimeWidget(list: listSelectTime[index]),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onPressed: () async {
                    widget.onSave(selectedList);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<CallTimeModel> selectedList = [];

  List<CallTimeModel> list = <CallTimeModel>[
    CallTimeModel(timeString: '00:00', hours: 0, minute: 0),
    CallTimeModel(timeString: '01:00', hours: 1, minute: 0),
    CallTimeModel(timeString: '02:00', hours: 2, minute: 0),
    CallTimeModel(timeString: '03:00', hours: 3, minute: 0),
    CallTimeModel(timeString: '04:00', hours: 4, minute: 0),
    CallTimeModel(timeString: '05:00', hours: 5, minute: 0),
    CallTimeModel(timeString: '06:00', hours: 6, minute: 0),
    CallTimeModel(timeString: '07:00', hours: 7, minute: 0),
    CallTimeModel(timeString: '08:00', hours: 8, minute: 0),
    CallTimeModel(timeString: '09:00', hours: 9, minute: 0),
    CallTimeModel(timeString: '10:00', hours: 10, minute: 0),
    CallTimeModel(timeString: '11:00', hours: 11, minute: 0),
    CallTimeModel(timeString: '12:00', hours: 12, minute: 0),
    CallTimeModel(timeString: '13:00', hours: 13, minute: 0),
    CallTimeModel(timeString: '14:00', hours: 14, minute: 0),
    CallTimeModel(timeString: '15:00', hours: 15, minute: 0),
    CallTimeModel(timeString: '16:00', hours: 16, minute: 0),
    CallTimeModel(timeString: '17:00', hours: 17, minute: 0),
    CallTimeModel(timeString: '18:00', hours: 18, minute: 0),
    CallTimeModel(timeString: '19:00', hours: 19, minute: 0),
    CallTimeModel(timeString: '20:00', hours: 20, minute: 0),
    CallTimeModel(timeString: '21:00', hours: 21, minute: 0),
    CallTimeModel(timeString: '22:00', hours: 22, minute: 0),
    CallTimeModel(timeString: '23:00', hours: 23, minute: 0),
  ];

  Widget selectTimeWidget(
      {required CallTimeModel list, bool isFromSelectedTime = false}) {
    return GestureDetector(
      onTap: () {
        if (isFromSelectedTime) {
          selectedList.remove(list);
          setState(() {});
          return;
        }
        if (selectedList.contains(list)) {
          selectedList.remove(list);
        } else {
          selectedList.add(list);
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            color: isFromSelectedTime ? Colors.green : Colors.black,
            borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(list.timeString),
            if (isFromSelectedTime) ...[
              const SizedBox(height: 5),
              const Icon(
                Icons.clear,
                color: Colors.white,
                size: 14,
              ),
            ]
          ],
        ),
      ),
    );
  }

  List<CallTimeModel> manageSelectTime() {
    List<CallTimeModel> unSelected = [];
    for (var element in list) {
      if (selectedList
          .where((t) => t.timeString == element.timeString)
          .toList()
          .isEmpty) {
        unSelected.add(element);
      }
    }
    return unSelected;
  }
}
