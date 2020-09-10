import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  final url;

  Networking({this.url});

  Future getData() async {
    http.Response response = await http.get(url);

    int code = response.statusCode;

    if (code == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data)['rate'];
    } else {
      print(code);
    }
  }
}
