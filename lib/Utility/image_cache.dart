import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_advanced_networkimage_2/transition.dart';

class ImageCaching extends StatelessWidget {
  final String url;
  final BoxFit boxFit;
  final Widget errorWidget;
  final Widget loadingWidget;
  final double height;
  final double width;

  const ImageCaching(
      {Key? key,
      required this.url,
      required this.boxFit,
      required this.errorWidget,
      required this.loadingWidget,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransitionToImage(
      image: AdvancedNetworkImage(url, printError: false),
      loadingWidgetBuilder: (_, double progress, __) => loadingWidget,
      fit: boxFit,
      placeholder: Center(
        child: errorWidget,
      ),
      printError: false,
      width: width,
      height: height,
      enableRefresh: true,
    );
  }
}
