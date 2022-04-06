// MY CONFIG
import 'package:flutter/material.dart';
import 'package:portal_berita_api/api/api.dart';
import 'package:portal_berita_api/api/list_response/data.dart';
import 'package:portal_berita_api/pages/viewer.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  var data = <Data>[];

  void _getListNews() async {
    Api.getListNews().then((value) {
      setState(() {
        data = value.data;
      });
    }).catchError((err) {
      print(err);
    });
  }

  //function yang memungkinkan untuk mengeksekusi statement2 didalamnya pertama kali sebelum menampilkan widget2
  @override
  void initState() {
    super.initState();
    _getListNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Gallery Berita Lauwba",
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Viewer(
                        judulNews: data[index].jdl_news,
                        imgUrl: data[index].foto_news,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Image.network(
                      data[index].foto_news,
                      fit: BoxFit.cover,
                      width: 500,
                      height: 275,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        // expectedTotalBytes = total ukuran gambar
                        // cumulativeBytesLoaded = ukuran gambar yang sedang diload
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            width: 80,
                            height: 80,
                            child: CircularProgressIndicator(
                              strokeWidth: 6.0,
                              value:
                                  (loadingProgress.expectedTotalBytes != null)
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
