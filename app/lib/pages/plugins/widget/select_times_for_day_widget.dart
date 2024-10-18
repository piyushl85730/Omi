import 'package:flutter/material.dart';

//ignore: must_be_immutable
class SelectTimesForDayWidget extends StatefulWidget {
  final String day;
  const SelectTimesForDayWidget({super.key, required this.day});

  @override
  State<SelectTimesForDayWidget> createState() =>
      _SelectTimesForDayWidgetState();
}

class _SelectTimesForDayWidgetState extends State<SelectTimesForDayWidget> {
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
              List<String> listSelectTime = manageSelectTime();
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
                  onPressed: () async {},
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

  List<String> selectedList = [];

  List<String> list = <String>[
    '00:00',
    '01:00',
    '02:00',
    '03:00',
    '04:00',
    '05:00',
    '06:00',
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
  ];

  Widget selectTimeWidget(
      {required String list, bool isFromSelectedTime = false}) {
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
            Text(list),
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

  List<String> manageSelectTime() {
    List<String> unSelected = [];
    for (var element in list) {
      if (selectedList.contains(element) == false) {
        unSelected.add(element);
      }
    }
    return unSelected;
  }
}
