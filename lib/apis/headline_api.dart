import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jpnn2/const.dart';
import 'package:jpnn2/model/headline_model.dart';

class HeadlineApi {
  static Future<List<HeadlineModel>?> get(int page) async {
    final _result = await http.get(
      Uri.parse("${baseUrlQ}top-headlines?country=id&page=$page&apiKey=$key"),
    );
    try {
      final _data = jsonDecode(_result.body);
      List temp = _data['articles'];
      List<HeadlineModel> cc = [];
      temp.map((e) => cc.add(HeadlineModel.fromJson(e))).toList();
      return cc;
    } catch (e) {
      print("HeadlineApiERROR: $e");
    }
  }
}
