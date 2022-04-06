import 'package:portal_berita_api/api/api.dart';
import 'package:portal_berita_api/api/list_response/data.dart';
import 'package:portal_berita_api/api/list_response/list_berita_response.dart';
import 'package:portal_berita_api/pages/detail_berita.dart';
import 'package:flutter/material.dart';

class ListBerita extends StatefulWidget {
  const ListBerita({Key? key}) : super(key: key);

  @override
  _ListBeritaState createState() => _ListBeritaState();
}

class _ListBeritaState extends State<ListBerita> {
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
        title:
            Text("List Berita Lauwba", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: 20),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailBerita(id: data[index].id),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.5,
                        spreadRadius: 0.5),
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      data[index].foto_news,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(20),
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
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 40),
                            child: Text(
                              data[index].jdl_news,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(data[index].post_on),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
