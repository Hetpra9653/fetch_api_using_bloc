import 'dart:convert';

import 'package:fetch_api_using_provider_part2/model/model.dart';
import 'package:http/http.dart';

class UserRepository {
  String userUrl = 'https://reqres.in/api/users/';

  Future<List<Data>> getUsers() async {
    Response response = await get(Uri.parse(userUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Data.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
