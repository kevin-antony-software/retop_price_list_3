import 'dart:convert';

import 'package:http/http.dart' as http;

import 'machine.dart';

List<Machine> parseMachines(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Machine>((json) => Machine.fromJson(json)).toList();
}

Stream<List<Machine>> fetchMachines(
  http.Client client,
  Duration refreshTime,
) async* {
  await Future.delayed(refreshTime);
  final response = await client
      .get(Uri.parse('https://kevin-antony.com/jsonFiles/csvjson.json'));
  yield parseMachines(response.body);
}
