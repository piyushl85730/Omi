import 'package:flutter/material.dart';

final List<Map<String, dynamic>> timezoneList = [
  {"label": "UTC-11", "offset": -11},
  {"label": "UTC-10", "offset": -10},
  {"label": "UTC-09", "offset": -9},
  {"label": "UTC-08", "offset": -8},
  {"label": "UTC-07", "offset": -7},
  {"label": "UTC-06", "offset": -6},
  {"label": "UTC-05", "offset": -5},
  {"label": "UTC-04", "offset": -4},
  {"label": "UTC-03", "offset": -3},
  {"label": "UTC-02", "offset": -2},
  {"label": "UTC-01", "offset": -1},
  {"label": "UTC+00", "offset": 0},
  {"label": "UTC+01", "offset": 1},
  {"label": "UTC+02", "offset": 2},
  {"label": "UTC+03", "offset": 3},
  {"label": "UTC+04", "offset": 4},
  {"label": "UTC+05", "offset": 5},
  {"label": "UTC+06", "offset": 6},
  {"label": "UTC+07", "offset": 7},
  {"label": "UTC+08", "offset": 8},
  {"label": "UTC+09", "offset": 9},
  {"label": "UTC+10", "offset": 10},
  {"label": "UTC+11", "offset": 11}
];

class TimezoneDropdown extends StatefulWidget {
  const TimezoneDropdown({super.key, required this.onSelectedTimezone});

  final Function(int) onSelectedTimezone;

  @override
  State<TimezoneDropdown> createState() => _TimezoneDropdownState();
}

class _TimezoneDropdownState extends State<TimezoneDropdown> {
  int? selectedTimezone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<int>(
        hint: const Text("Timezone"),
        value: selectedTimezone,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        style: const TextStyle(color: Colors.white, fontSize: 15),
        items: timezoneList.map((language) {
          return DropdownMenuItem<int>(
              value: language['offset'], child: Text(language['label']!));
        }).toList(),
        onChanged: (value) {
          selectedTimezone = value;
          setState(() {});
          widget.onSelectedTimezone(int.parse(selectedTimezone.toString()));
        },
      ),
    );
  }
}
