import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/env/env.dart';

Future<void> saveFcmTokenServer({
  required String token,
  required String timeZone,
}) async {
  // Log the request details
  debugPrint(
      'saveFcmTokenServer Request URL: ${Env.apiBaseUrl}v1/users/fcm-token');
  debugPrint('saveFcmTokenServer Request Method: POST');
  debugPrint('saveFcmTokenServer Request Headers: ${jsonEncode({
        'Content-Type': 'application/json'
      })}');
  debugPrint('saveFcmTokenServer Request Body: ${jsonEncode({
        'fcm_token': token,
        'time_zone': timeZone
      })}');

  // Make the API call
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v1/users/fcm-token',
    headers: {'Content-Type': 'application/json'},
    method: 'POST',
    body: jsonEncode({'fcm_token': token, 'time_zone': timeZone}),
  );

  // Log the response details
  debugPrint(
      'saveFcmTokenServer Response Status Code: ${response?.statusCode}');
  debugPrint('saveFcmTokenServer Response Body: ${response?.body}');

  // Handle the response
  if (response == null) {
    debugPrint('saveFcmTokenServer: No response received');
  } else if (response.statusCode == 200) {
    debugPrint('saveFcmTokenServer: Token saved successfully');
  } else {
    debugPrint('saveFcmTokenServer: Failed to save token');
  }
}
