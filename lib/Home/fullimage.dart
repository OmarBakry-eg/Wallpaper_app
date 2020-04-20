import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class FullImage extends StatefulWidget {
  final imgUrl;
  FullImage({this.imgUrl});
  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SnackBar snackBar = SnackBar(
    content: Text(
      'Image Has Been Saved To Gallery',
      style: TextStyle(color: Colors.white),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Image(
              image: CachedNetworkImageProvider(widget.imgUrl),
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(45),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Save Image Now',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                  onTap: () {
                    _saveNetworkImage();
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _saveNetworkImage() async {
    String path = widget.imgUrl;
    GallerySaver.saveImage(path, albumName: 'Flutter Wallpaper App OB')
        .then((bool success) {
      setState(() {
        print('Image is saved');
      });
    });
  }
}
