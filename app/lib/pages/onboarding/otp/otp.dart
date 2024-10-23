import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/backend/preferences.dart';
import 'package:friend_private/pages/onboarding/otp/pin_put_widget.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class OTPPage extends StatefulWidget {
  final VoidCallback onNext;

  const OTPPage({super.key, required this.onNext});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with SingleTickerProviderStateMixin {
  TextEditingController smsCodeController = TextEditingController();

  //bool isSwitched = false;

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
            children: [
              const SizedBox(height: 40),
              const Text(
                'Enter OTP',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPinPut(context, smsCodeController),
                ],
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Call Now : ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.white24,
                    inactiveThumbColor: Colors.white54,
                  ),
                ],
              ),*/
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
                        if (smsCodeController.text.length == 6) {
                          changeLoadingState();
                          bool isSuccessful = await verifyOTPApi(context);
                          changeLoadingState();
                          if (isSuccessful) {
                            widget.onNext();
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Invalid OTP'),
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
                    'Verify OTP',
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

  Future<bool> verifyOTPApi(BuildContext context) async {
    var mainHeaders = {
      "accept": "application/json",
      "Authorization": await getAuthHeader()
    };

    Map<String, dynamic> passDate = {
      "phone": SharedPreferencesUtil().phoneNumber,
      "code": smsCodeController.text,
      "isCallNow": false
    };

    var response = await makeApiCall(
      url:
          'https://agiens-backend-662477620892.us-central1.run.app/api/v1/auth/login-code-finish',
      method: 'POST',
      headers: mainHeaders,
      body: json.encode(passDate),
    );

    debugPrint("verifyOTPApi response :- ${response?.body}");
    debugPrint("verifyOTPApi response :- ${response?.statusCode}");
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
