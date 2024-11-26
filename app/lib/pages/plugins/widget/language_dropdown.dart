import 'package:flutter/material.dart';

final List<Map<String, String>> languagesList = [
  {"code": "en", "name": "English"},
  {"code": "en-US", "name": "English (US)"},
  {"code": "en-GB", "name": "English (UK)"},
  {"code": "en-AU", "name": "English (Australia)"},
  {"code": "en-NZ", "name": "English (New Zealand)"},
  {"code": "en-IN", "name": "English (India)"},
  {"code": "zh", "name": "Chinese (Simplified)"},
  {"code": "zh-CN", "name": "Chinese (Simplified, China)"},
  {"code": "zh-Hans", "name": "Chinese (Simplified, Hans)"},
  {"code": "zh-TW", "name": "Chinese (Traditional)"},
  {"code": "zh-Hant", "name": "Chinese (Traditional, Hant)"},
  {"code": "es", "name": "Spanish"},
  {"code": "es-419", "name": "Spanish (Latin America)"},
  {"code": "fr", "name": "French"},
  {"code": "fr-CA", "name": "French (Canada)"},
  {"code": "de", "name": "German"},
  {"code": "el", "name": "Greek"},
  {"code": "hi", "name": "Hindi"},
  {"code": "hi-Latn", "name": "Hindi (Latin script)"},
  {"code": "ja", "name": "Japanese"},
  {"code": "ko", "name": "Korean"},
  {"code": "ko-KR", "name": "Korean (Korea)"},
  {"code": "pt", "name": "Portuguese"},
  {"code": "pt-BR", "name": "Portuguese (Brazil)"},
  {"code": "it", "name": "Italian"},
  {"code": "nl", "name": "Dutch"},
  {"code": "pl", "name": "Polish"},
  {"code": "ru", "name": "Russian"},
  {"code": "sv", "name": "Swedish"},
  {"code": "sv-SE", "name": "Swedish (Sweden)"},
  {"code": "da", "name": "Danish"},
  {"code": "da-DK", "name": "Danish (Denmark)"},
  {"code": "fi", "name": "Finnish"},
  {"code": "id", "name": "Indonesian"},
  {"code": "ms", "name": "Malay"},
  {"code": "tr", "name": "Turkish"},
  {"code": "uk", "name": "Ukrainian"},
  {"code": "bg", "name": "Bulgarian"},
  {"code": "cs", "name": "Czech"},
  {"code": "ro", "name": "Romanian"},
  {"code": "sk", "name": "Slovak"},
];

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown(
      {super.key,
      required this.onSelectedLanguage,
      required this.selectedLanguage});

  final Function(String) onSelectedLanguage;
  final String? selectedLanguage;

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    selectedLanguage = widget.selectedLanguage;
    debugPrint("LanguageDropdown -> $selectedLanguage");
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        hint: const Text("Select a Language"),
        value: selectedLanguage,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        style: const TextStyle(color: Colors.white, fontSize: 15),
        items: languagesList.map((language) {
          return DropdownMenuItem<String>(
              value: language['code'], child: Text(language['name']!));
        }).toList(),
        onChanged: (value) {
          selectedLanguage = value;
          setState(() {});
          widget.onSelectedLanguage(selectedLanguage ?? "");
        },
      ),
    );
  }
}
