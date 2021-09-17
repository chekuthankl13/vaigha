import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vaigha/models/functions.dart';

class FetchFunctions {
  Future<Functions> fetchData(String? query) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(
        'https://raw.githubusercontent.com/hasinhayder/wp-functions-list/master/wpfunctions.json'));
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      var function = Functions.fromJson(decodedJson);
      if (query != null) {
        var list = Functions(
            definitions: function.definitions
                .where((element) =>
                    element.name.toLowerCase().contains(query.toLowerCase()))
                .toList());
        return list;
      }
      return function;
    } else {
      return throw Exception('server is down');
    }
  }
}
