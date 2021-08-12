import 'package:flutter/foundation.dart';
import 'package:jpnn2/apis/headline_api.dart';
import 'package:jpnn2/apis/headline_search_api.dart';
import 'package:jpnn2/model/headline_model.dart';

class HeadlineProvider extends ChangeNotifier {
  int _page = 1;

  List<HeadlineModel> _headlineModel = [];
  List<HeadlineModel> _headlineSearchModel = [];

  List<HeadlineModel?> get getHeadline => _headlineModel;
  List<HeadlineModel?> get getHeadlineSearch => _headlineSearchModel;
  int get getPage => _page;

  clear() {
    _headlineModel.clear();
    notifyListeners();
  }

  searchClear() {
    _headlineSearchModel.clear();
    notifyListeners();
  }

  Future<List<HeadlineModel?>> setHeadLine([
    bool isScroll = false,
    bool isPull = false,
  ]) async {
    if (isPull) {
      _headlineModel.clear();
      setHeadLine();
    }

    if (isScroll) _page++;
    _headlineModel.addAll(await HeadlineApi.get(_page) ?? []);
    notifyListeners();
    return _headlineModel;
  }

  Future<List<HeadlineModel?>> setHeadLineSearch(String keyword) async {
    print("objectcC");
    _headlineSearchModel = (await HeadlineSearchApi.get(keyword) ?? []);
    notifyListeners();
    return _headlineSearchModel;
  }
}
