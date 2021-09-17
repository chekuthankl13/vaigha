import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vaigha/models/hooks.dart';

class FetchHooks {
  Future<Hooks> fetchData(String? query) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(
        'https://raw.githubusercontent.com/johnbillion/wp-hooks/master/hooks/actions.json'));
    if (response.statusCode == 200) {
      var decodedjson = await jsonDecode(response.body);

      var hooks = Hooks.fromJson(decodedjson);
      if (query != null) {
        var list = Hooks(
            hooks: hooks.hooks
                .where((element) =>
                    element.name!.toLowerCase().contains(query.toLowerCase()))
                .toList());

        return list;
      } else {
        return hooks;
      }
    } else {
      throw Exception('server is down');
    }
  }
}
