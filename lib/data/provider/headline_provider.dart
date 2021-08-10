import 'package:flutter/foundation.dart';
import 'package:jpnn2/data/api/headline_api.dart';
import 'package:jpnn2/data/api/headline_search_api.dart';
import 'package:jpnn2/data/models/headline_model.dart';

class HeadlineProvider extends ChangeNotifier {
  int _page = 1;

  List<HeadlineModel> _headlineModel = [];
  List<HeadlineModel>? _headlineSearchModel;

  Future clear() async {
    _headlineModel.clear();
    notifyListeners();
  }

  Future<List<HeadlineModel?>> setHeadLine([
    bool isScroll = false,
    bool isPull = false,
  ]) async {
    if (isPull) {
      _headlineModel.clear();
      await Future.delayed(Duration(seconds: 2), () => setHeadLine());
    }

    if (isScroll) _page += 1;
    _headlineModel.addAll(await HeadlineApi.get(_page) ?? []);
    notifyListeners();
    return _headlineModel;
  }

  Future<List<HeadlineModel?>> setHeadLineSearch(String keyword) async {
    print(" printme");
    _headlineSearchModel = (await HeadlineSearchApi.get(keyword)) ?? [];
    print(" search3 ${_headlineSearchModel?[0].author}");
    notifyListeners();
    return _headlineSearchModel ?? [];
  }

  List<HeadlineModel?> get getHeadline => _headlineModel;
  List<HeadlineModel?> get getHeadlineSearch => _headlineSearchModel ?? [];
  int get getPage => _page;
}
