import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:news_app/NewList/Controllers/news_list_controller.dart';
import 'package:news_app/NewList/Screens/new_error.dart';
import 'package:news_app/NewList/Screens/single_news_item.dart';
import 'package:news_app/Repository/NewsApi/Model/article.dart';
import 'package:news_app/Utility/theme_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        title: const Text("News App"),
        actions: [
          IconButton(
              onPressed: () {
                ThemeService().switchTheme();
              },
              icon: Icon(!Get.isDarkMode ? Icons.dark_mode : Icons.light_mode)),
        ],
      ),
      body: Center(
        child: GetBuilder<NewsListController>(
            init: Get.find<NewsListController>(),
            builder: (controller) {
              return PagedListView(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Article>(
                    firstPageErrorIndicatorBuilder: (_) =>
                        const NewsErrorDisplay(),
                    itemBuilder: (context, item, index) =>
                        SingleNewsItem(singleArticle: item),
                  ));
            }),
      ),
    );
  }
}
