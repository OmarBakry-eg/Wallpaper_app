import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper_app/Home/fullimage.dart';

class StackMainWidget extends StatelessWidget {
  final img;
  StackMainWidget({this.img});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullImage(
                      imgUrl: img,
                    ),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(45)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(45),
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: img,
                  placeholder: (context, url) => FittedBox(
                    fit: BoxFit.none,
                    child: Container(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
