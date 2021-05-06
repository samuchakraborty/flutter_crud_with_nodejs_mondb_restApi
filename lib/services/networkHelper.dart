import 'dart:convert';

import 'package:http/http.dart' as http;

class Network {
  var baseUrl = 'https://warm-peak-37992.herokuapp.com';

  Future getAllPost() async {
    var url = Uri.parse(baseUrl + '/article');
    http.Response response = await http.get(url);
    print(response.body);
    try {

        final jsonResponse = jsonDecode(response.body);
        print(response.statusCode);
        return jsonResponse;


    } catch (e) {
      print(e);
    }
  }

  Future<http.Response> getItemUpdate({articleTitle, data}) async {
    var fullUrl = baseUrl + '/article/' + articleTitle;

    return await http.patch(Uri.parse(fullUrl), body: (data));
  }

  Future<http.Response> insertOneItem({data}) async {
    var fullUrl = baseUrl + '/articles';

    return await http.post(Uri.parse(fullUrl), body: data);
  }

  Future<http.Response> deleteItem({articleTitle, data}) async {
    var fullUrl = baseUrl + '/article/' + articleTitle;

    return await http.delete(Uri.parse(fullUrl), body: (data));
  }
}
