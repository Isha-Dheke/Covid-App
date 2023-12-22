import 'dart:convert';

import 'package:covidapp/Modal/Worldstate.dart';
import 'package:covidapp/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateService {
  Future<worldState> fetchWorldStateRecored() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return worldState.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
