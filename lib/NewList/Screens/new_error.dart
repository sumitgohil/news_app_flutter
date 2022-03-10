import 'package:flutter/material.dart';

class NewsErrorDisplay extends StatelessWidget {
  const NewsErrorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          Text("There Was Some Error Loading the Data, Please Try Again Later"),
    );
  }
}
