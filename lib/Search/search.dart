import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'searchResult.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(
      text: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.all(80),
            child: Container(
              child: Center(
                child: Text(
                  'The search will be based on what you write',
                  style: GoogleFonts.oswald(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
