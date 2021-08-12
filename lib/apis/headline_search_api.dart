import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jpnn2/const.dart';
import 'package:jpnn2/model/headline_model.dart';

class HeadlineSearchApi {
  static Future<List<HeadlineModel>?> get(String keyword) async {
    final _result = await http.get(
      Uri.parse("${baseUrlQ}everything?q=$keyword&page=1&apiKey=$key"),
    );

    print(jsonDecode(_result.body)['articles']);

    try {
      final _data = jsonDecode(_result.body);
      List temp = _data['articles'];
      List<HeadlineModel> cc = [];
      temp.map((e) => cc.add(HeadlineModel.fromJson(e))).toList();
      return cc;
    } catch (e) {
      print("HeadlineSearchApi $e");
    }
  }
}
