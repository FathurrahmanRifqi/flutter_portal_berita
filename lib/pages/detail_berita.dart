import 'package:portal_berita_api/api/api.dart';
import 'package:portal_berita_api/api/detail_response/detail_berita_response.dart';
import 'package:flutter/material.dart';

class DetailBerita extends StatefulWidget {
  final String id;

  const DetailBerita({Key? key, required this.id}) : super(key: key);

  @override
  _DetailBeritaState createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  String judul = "",
      postOn = "",
      ketNews = "",
      foto = "https://www.freeiconspng.com/uploads/no-image-icon-15.png";

  void _getDetailNews() async {
    Api.getDetailNews(widget.id).then((value) {
      setState(() {
        judul = value.jdl_news;
        postOn = value.post_on;
        ketNews = value.ket_news;
        foto = value.foto_news;
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetailNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Detail Berita", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Text(
                judul,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                postOn,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.purple[300]),
              ),
              SizedBox(
                height: 23,
              ),
              Image.network(
                foto,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  // expectedTotalBytes = total ukuran gambar
                  // cumulativeBytesLoaded = ukuran gambar yang sedang diload
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        strokeWidth: 6.0,
                        value: (loadingProgress.expectedTotalBytes != null)
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                ketNews,
                style: TextStyle(
                  height: 1.8,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
