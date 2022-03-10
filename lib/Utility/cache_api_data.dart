import 'package:get_storage/get_storage.dart';
import 'package:news_app/Repository/NewsApi/Model/article.dart';
import 'package:prefs/prefs.dart';

class CacheApi {
  final box = GetStorage();

  putCacheData(String _storeKey, List<Article> _articles) {
    box.write(_storeKey, articlesToJson(_articles));

    // UNCOMMENT THE BELOW LINE TO USE SHARED PREFS, COMMENT THE ABOVE LINE

    // Prefs.setString(_storeKey, articlesToJson(_articles));
  }

  Future<bool> checkIfCacheExist(String _storeKey) {
    return Future.value(box.hasData(_storeKey));

    // UNCOMMENT THE BELOW LINE TO USE SHARED PREFS, COMMENT THE ABOVE LINE

    // return Future.value(Prefs.containsKey(_storeKey));
  }

  List<Article> getCachedData(String _storeKey) {
    return articlesFromJson(box.read(_storeKey));

    // UNCOMMENT THE BELOW LINE TO USE SHARED PREFS, COMMENT THE ABOVE LINE

    // return articlesFromJson(Prefs.getString(_storeKey));

    // FOR USING SQLITE
    // THE _storeKey CAN BE USED TO SEARCH IN TABLE AS PRIMARY KEY AND RETURN THE DATA
  }

  // THIS METHOD IS ONLY USED FOR DEVELOPMENT PURPOSE
  clearCache() {
    box.erase();

    Prefs.clear();
  }
}
