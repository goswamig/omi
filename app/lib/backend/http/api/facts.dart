import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/backend/schema/fact.dart';
import 'package:friend_private/env/env.dart';

Future<bool> createFactServer(String content, FactCategory category) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v1/facts',
    headers: {},
    method: 'POST',
    body: json.encode({
      'content': content,
      'category': category.toString().split('.').last,
    }),
  );
  if (response == null) return false;
  debugPrint('createFact response: ${response.body}');
  return response.statusCode == 200;
}

Future<List<Fact>> getFacts({int limit = 100, int offset = 0}) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v2/facts?limit=${limit}&offset=${offset}',
    headers: {},
    method: 'GET',
    body: '',
  );
  if (response == null) return [];
  debugPrint('getFacts response: ${response.body}');
  List<dynamic> facts = json.decode(response.body);
  return facts.map((fact) => Fact.fromJson(fact)).toList();
}

Future<bool> deleteFactServer(String factId) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v1/facts/$factId',
    headers: {},
    method: 'DELETE',
    body: '',
  );
  if (response == null) return false;
  debugPrint('deleteFact response: ${response.body}');
  return response.statusCode == 200;
}

Future<bool> reviewFactServer(String factId, bool value) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v1/facts/$factId/review?value=$value',
    headers: {},
    method: 'POST',
    body: '',
  );
  if (response == null) return false;
  debugPrint('reviewFact response: ${response.body}');
  return response.statusCode == 200;
}

Future<bool> editFactServer(String factId, String value) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v1/facts/$factId?value=$value',
    headers: {},
    method: 'PATCH',
    body: '',
  );
  if (response == null) return false;
  debugPrint('editFact response: ${response.body}');
  return response.statusCode == 200;
}
