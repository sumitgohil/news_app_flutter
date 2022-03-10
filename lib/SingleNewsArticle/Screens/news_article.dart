import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Repository/NewsApi/Model/article.dart';
import 'package:news_app/Utility/image_cache.dart';
import 'package:news_app/Utility/utils.dart';

class SingleArticleScreen extends StatelessWidget {
  final Article article;
  const SingleArticleScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SingleNewsImage(article: article),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: Get.height * .27),
              padding: const EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Utils().formatDate(article.publishedAt ?? DateTime.now()),
                    style: context.theme.textTheme.bodySmall,
                  ),
                  Text(
                    article.title ?? "",
                    style: GoogleFonts.poppinsTextTheme(context.theme.textTheme)
                        .headline5,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SourceBox(article: article),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    article.description ?? "",
                    style: GoogleFonts.poppinsTextTheme(context.theme.textTheme)
                        .bodySmall!
                        .copyWith(fontSize: 18),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: context.theme.canvasColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            ),
          )
        ],
      ),
    );
  }
}

class SourceBox extends StatelessWidget {
  const SourceBox({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.my_library_books, size: 16),
        const SizedBox(
          width: 8,
        ),
        Text(
          article.source.name ?? "",
          style: context.theme.textTheme.bodySmall,
        )
      ],
    );
  }
}

class SingleNewsImage extends StatelessWidget {
  const SingleNewsImage({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .3,
      color: Colors.blue,
      child: Hero(
        tag: article.urlToImage ?? article.url!,
        child: ImageCaching(
            url: article.urlToImage ?? "",
            boxFit: BoxFit.cover,
            errorWidget: const Icon(Icons.replay_outlined),
            loadingWidget: const LinearProgressIndicator(),
            height: Get.height * .3,
            width: double.infinity),
      ),
    );
  }
}
