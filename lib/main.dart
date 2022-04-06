import 'package:flutter/material.dart';

import 'pages/list_berita.dart';
import 'pages/gallery_berita.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple[300],
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            ListBerita(),
            GalleryScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.purple[300],
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            indicatorWeight: 2.5,
            tabs: [
              Tab(
                icon: Icon(Icons.language),
              ),
              Tab(
                icon: Icon(Icons.photo_library),
              )
            ],
          ),
        ),
      ),
    );
  }
}
