import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/utils/library/country_code_picker/countries.dart';
import 'package:friend_private/utils/library/country_code_picker/phone_number.dart';
import 'package:friend_private/utils/library/country_code_picker/phone_number_field.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class PhonePage extends StatefulWidget {
  final VoidCallback onNext;

  const PhonePage({super.key, required this.onNext});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage>
    with SingleTickerProviderStateMixin {
  TextEditingController phoneNumberEditingController = TextEditingController();
  PhoneNumber? phoneNumber;
  Country country = const Country(
      name: "United States",
      flag: "🇺🇸",
      code: "US",
      dialCode: "1",
      minLength: 10,
      maxLength: 10);

  bool loading = false;

  changeLoadingState() => setState(() => loading = !loading);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Mobile Number',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              mobileTextField(),
            ],
          ),
          Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: loading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.1, right: screenSize.width * 0.1),
            child: Container(
              decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(127, 208, 208, 208),
                    Color.fromARGB(127, 188, 99, 121),
                    Color.fromARGB(127, 86, 101, 182),
                    Color.fromARGB(127, 126, 190, 236)
                  ]),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                onPressed: loading
                    ? () {}
                    : () async {
                        if (phoneNumber != null) {
                          if (phoneNumber!.number.length >= country.minLength &&
                              phoneNumber!.number.length <= country.maxLength) {
                            changeLoadingState();
                            bool isSuccessful = await sendOTPApi(context);
                            changeLoadingState();
                            if (isSuccessful) {
                              widget.onNext();
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Invalid phone number'),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Empty phone number'),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: const Color.fromARGB(255, 17, 17, 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  // Button takes full width of the padding
                  height: 45,
                  // Fixed height for the button
                  alignment: Alignment.center,
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: screenSize.width * 0.045,
                        color: const Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileTextField() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: IntlPhoneField(
        controller: phoneNumberEditingController,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        dropdownIconPosition: IconPosition.trailing,
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.bottom,
        dropdownIcon:
            const Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
        dropdownTextStyle: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        disableLengthCheck: true,
        flagsButtonPadding: const EdgeInsets.only(left: 18),
        initialCountryCode: 'US',
        onChanged: (phone) {
          phoneNumber = phone;
        },
        onCountryChanged: (cntry) {
          country = cntry;
        },
      ),
    );
  }

  Future<bool> sendOTPApi(BuildContext context) async {
    var mainHeaders = {
      "accept": "application/json",
      "Authorization": await getAuthHeader()
    };

    SharedPreferencesUtil().phoneNumber =
        "${phoneNumber!.countryCode}${phoneNumber!.number}";

    Map<String, dynamic> passDate = {
      "phone": "${phoneNumber!.countryCode}${phoneNumber!.number}"
    };

    var response = await makeApiCall(
      url:
          'https://agiens-backend-662477620892.us-central1.run.app/api/v1/auth/update-phone',
      method: 'POST',
      headers: mainHeaders,
      body: json.encode(passDate),
    );

    debugPrint("sendOTPApi response :- ${response?.body}");
    debugPrint("sendOTPApi response :- ${response?.statusCode}");
    if (response!.statusCode == 200) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Something went wrong please try again!'),
      duration: Duration(seconds: 1),
    ));
    return false;
  }
}
