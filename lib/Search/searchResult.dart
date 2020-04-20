import 'dart:math';
import '../ReusableAndApi/reusable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/ReusableAndApi/api.dart';

const apiKey = '16008883-55bdb86ddba89e3fb7dbf85f0';

class SearchResult extends StatefulWidget {
  final String text;
  SearchResult({this.text});
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Future getApiData() async {
    Api api = Api(
        'https://pixabay.com/api/?key=$apiKey&q=${widget.text}&image_type=photo&pretty=true');
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
