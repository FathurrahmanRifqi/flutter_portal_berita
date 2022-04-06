import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Viewer extends StatelessWidget {
  final String judulNews;
  final String imgUrl;
  const Viewer(
      {Key? key,
      required this.judulNews,
      this.imgUrl =
          "https://image.indonetwork.co.id/f-webp/products/thumbs/300x300/2021/01/20/63ebdd03-3c06-4349-8cda-e220692e024b.jpg"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(judulNews, style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: PhotoView(
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            imageProvider: NetworkImage(imgUrl)),
      ),
    );
  }
}
