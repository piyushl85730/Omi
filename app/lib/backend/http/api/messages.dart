import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/backend/schema/message.dart';
import 'package:friend_private/env/env.dart';

Future<List<ServerMessage>> getMessagesServer() async {
  // Construct the request URL
  final url = '${Env.apiBaseUrl}v1/messages';

  // Log the request details
  debugPrint('getMessagesServer Request URL: $url');
  debugPrint('getMessagesServer Request Method: GET');
  debugPrint(
      'getMessagesServer Request Headers: {}'); // No headers in this case
  debugPrint('getMessagesServer Request Body: '); // Empty body for this request

  // Make the API call
  var response = await makeApiCall(
    url: url,
    headers: {},
    method: 'GET',
    body: '',
  );

  // Check if response is null
  if (response == null) {
    debugPrint('getMessagesServer: No response received.');
    return [];
  }

  // Log the response status code and body
  debugPrint('getMessagesServer Response Status Code: ${response.statusCode}');
  debugPrint('getMessagesServer Response Body: ${response.body}');

  // Handle the response
  if (response.statusCode == 200) {
    try {
      var messages = (jsonDecode(response.body) as List<dynamic>)
          .map((message) => ServerMessage.fromJson(message))
          .toList();
      debugPrint('getMessagesServer length: ${messages.length}');
      return messages;
    } catch (e) {
      debugPrint('getMessagesServer: Error decoding JSON - $e');
    }
  }

  return [];
}

Future<ServerMessage> sendMessageServer(String text, {String? pluginId}) async {
  // Construct the request URL
  final url = '${Env.apiBaseUrl}v1/messages?plugin_id=$pluginId';

  // Log the request details
  debugPrint('sendMessageServer Request URL: $url');
  debugPrint('sendMessageServer Request Method: POST');
  debugPrint(
      'sendMessageServer Request Headers: {}'); // No headers in this case
  debugPrint('sendMessageServer Request Body: ${jsonEncode({'text': text})}');

  // Make the API call
  var response = await makeApiCall(
    url: url,
    headers: {},
    method: 'POST',
    body: jsonEncode({'text': text}),
  );

  // Log the response status code and body
  debugPrint('sendMessageServer Response Status Code: ${response?.statusCode}');
  debugPrint('sendMessageServer Response Body: ${response?.body}');

  // Handle the response
  if (response == null) {
    throw Exception('Failed to receive response');
  }
  if (response.statusCode == 200) {
    try {
      return ServerMessage.fromJson(jsonDecode(response.body));
    } catch (e) {
      debugPrint('sendMessageServer: Error decoding JSON - $e');
      throw Exception('Failed to decode response');
    }
  } else {
    throw Exception('Failed to send message');
  }
}

Future<ServerMessage> getInitialPluginMessage(String? pluginId) async {
  // Construct the request URL
  final url = '${Env.apiBaseUrl}v1/initial-message?plugin_id=$pluginId';

  // Log the request details
  debugPrint('getInitialPluginMessage Request URL: $url');
  debugPrint('getInitialPluginMessage Request Method: POST');
  debugPrint(
      'getInitialPluginMessage Request Headers: {}'); // No headers in this case
  debugPrint(
      'getInitialPluginMessage Request Body: '); // Empty body for this request

  // Make the API call
  var response = await makeApiCall(
    url: url,
    headers: {},
    method: 'POST',
    body: '',
  );

  // Log the response status code and body
  debugPrint(
      'getInitialPluginMessage Response Status Code: ${response?.statusCode}');
  debugPrint('getInitialPluginMessage Response Body: ${response?.body}');

  // Handle the response
  if (response == null) {
    throw Exception('Failed to receive response');
  }
  if (response.statusCode == 200) {
    try {
      return ServerMessage.fromJson(jsonDecode(response.body));
    } catch (e) {
      debugPrint('getInitialPluginMessage: Error decoding JSON - $e');
      throw Exception('Failed to decode response');
    }
  } else {
    throw Exception('Failed to get initial plugin message');
  }
}
