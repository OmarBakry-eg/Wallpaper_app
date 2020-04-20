import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import '../ReusableAndApi/reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/ReusableAndApi/api.dart';
import '../Search/search.dart';

const apiKey = '16008883-55bdb86ddba89e3fb7dbf85f0';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getApiData() async {
    Api api = Api('https://pixabay.com/api/?key=$apiKey');
    var apiData = await api.getData();
    return apiData;
  }

  var backGround;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    backGround = Random().nextInt(3) + 1;
  }

  Future<void> refreshPage() async {
    await getApiData();
    setState(() {
      backGround = Random().nextInt(3) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshPage,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage('img/$backGround.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            StreamBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data;
                List images = [];

                for (var loop in data['hits']) {
                  images.add(loop['largeImageURL']);
                }

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(
                        'Our Today\'s Image List',
                        style: GoogleFonts.raleway(
                          color: Colors.black,
                        ),
                      ),
                      centerTitle: true,
                      elevation: 5.0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.search,
                          size: 40,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                      ),
                      floating: true,
                      backgroundColor: Colors.white70,
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.5 / 0.8),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return StackMainWidget(
                            img: images[index],
                          );
                        },
                        childCount: images.length,
                      ),
                    ),
                  ],
                );
              },
              stream: getApiData().asStream(),
            ),
          ],
        ),
      ),
    );
  }
}
