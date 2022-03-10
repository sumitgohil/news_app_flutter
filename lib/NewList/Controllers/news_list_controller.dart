import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/Repository/NewsApi/Model/article.dart';
import 'package:news_app/Repository/NewsApi/Model/error.dart';
import 'package:news_app/Repository/NewsApi/news_api.dart';
import 'package:news_app/Utility/cache_api_data.dart';

class NewsListController extends GetxController {
  bool hasLoadedFirstTime = false, errorLoadingFirstTime = false;

  /// GETTING API FROM .ENV FILE
  NewsAPI newsApi = NewsAPI(dotenv.env['APIKEY']!);
  final String _newsFromCountry = "IN";
  final int _pageSize = 10;
  int _currentPage = 1;
  int? totalItems;

  final PagingController<int, Article> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fillTheData();
    });

    super.onInit();
  }

  ///METHOD TO FILL THE DATA EITHER FROM API OR CACHE
  fillTheData() {
    ///CREATING A SIMPLE KEY TO USE WITH ANY KIND OF STORAGE

    String _storeCacheKey =
        "newapi_${_newsFromCountry}_${_currentPage}_$_pageSize";

    CacheApi().checkIfCacheExist(_storeCacheKey).then((hasCacheData) {
      if (hasCacheData) {
        log("LOADED DATA FROM CACHE");
        addPaginatedData(CacheApi().getCachedData(_storeCacheKey));

        log("ADDING NEW FRESH DATA TO CACHE");
        getDataFromApi(_storeCacheKey, updateCache: true);
      } else {
        log("Loading Data from API");
        getDataFromApi(_storeCacheKey);
      }

      ////INCREASING PAGE AFTER SUCCESSFULL API CALL
      _currentPage++;
    });

    // getDataFromApi(_storeCacheKey);
  }

  getDataFromApi(String _storeCacheKey, {bool updateCache = false}) {
    newsApi
        .getTopHeadlines(
            country: _newsFromCountry, page: _currentPage, pageSize: _pageSize)
        .then((articles) {
      /// PREVENTING EMPTY DATA STORAGE IN CACHE
      if (articles.isNotEmpty) {
        CacheApi().putCacheData(_storeCacheKey, articles);
      }

      if (!updateCache) {
        //// AS WE HAVE ALREADY POPULATED THE LIST. NOT RE DOING IT
        addPaginatedData(articles);
      }
    }).catchError(handleApiError);
  }

  addPaginatedData(List<Article> _articles) {
    // CHANGES TO TRUE IF THE FIRST PAGE WAS LOADED SUCCESSFULLY
    hasLoadedFirstTime = true;
    update();

    // CHECKING IF IT SHOULD BE THE LAST PAGE FOR THE PAGINATION API CALL
    final isLastPage = _articles.length < _pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(_articles);
    } else {
      pagingController.appendPage(_articles, _currentPage);
    }
  }

  handleApiError(error) {
    pagingController.error = (error as NewsApiError).message!;
    log(error.toString());
    error.printInfo();
    error.printError();
    if (!hasLoadedFirstTime) {
      /// IF THE FIRST INITIAL DATA HAS ALREADY BEEN LOADED, We Won't be showing the error screen
      errorLoadingFirstTime = true;

      update();
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
