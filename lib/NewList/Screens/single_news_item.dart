import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Repository/NewsApi/Model/article.dart';
import 'package:news_app/Utility/utils.dart';

import './../../Utility/image_cache.dart';
import '../../SingleNewsArticle/Screens/news_article.dart';

class SingleNewsItem extends StatelessWidget {
  final Article singleArticle;
  const SingleNewsItem({Key? key, required this.singleArticle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: Get.width * .8,
      child: GestureDetector(
        onTap: () {
          Get.to(() => SingleArticleScreen(article: singleArticle));
        },
        child: Card(
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxHeight: Get.height * .21, minHeight: Get.height * .21),
                ////CACHING IMAGE
                child: Hero(
                  tag: singleArticle.urlToImage ?? singleArticle.url!,
                  child: ImageCaching(
                    url: singleArticle.urlToImage ?? "",
                    height: Get.height * .21,
                    width: double.infinity,
                    boxFit: BoxFit.cover,
                    loadingWidget: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  singleArticle.title ?? "",
                  style: GoogleFonts.poppinsTextTheme(context.theme.textTheme)
                      .titleMedium!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  singleArticle.description ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.theme.textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NewsListRowItems(
                        icon: Icons.my_library_books,
                        text: singleArticle.source.name!),
                    NewsListRowItems(
                        icon: Icons.date_range,
                        text: Utils().formatDate(
                            singleArticle.publishedAt ?? DateTime.now()))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsListRowItems extends StatelessWidget {
  final IconData icon;
  final String text;
  const NewsListRowItems({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 16),
      const SizedBox(
        width: 4,
      ),
      Text(
        text,
        style: context.theme.textTheme.bodySmall,
      )
    ]);
  }
}
