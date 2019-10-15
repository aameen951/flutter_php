import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestResult
{
  bool ok;
  dynamic data;

  RequestResult(this.ok, this.data);
}
Future<RequestResult> http_get(dynamic data) async
{
  var dataStr = jsonEncode(data);
  var url = "http://192.168.1.5/flutter_php/index.php?data=" + dataStr;
  var result = await http.get(url);
  if(result.headers['content-type'] == "application/json")
  {
    return RequestResult(true, jsonDecode(result.body));
  }
  else
  {
    print("============================");
    print("Request Error:");
    print(data);
    print(result.body);
    print("============================");
    return RequestResult(false, null);
  }
}

