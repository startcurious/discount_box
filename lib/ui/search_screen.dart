import 'dart:ui';

import 'package:flutter/material.dart';

class Search_Screen extends StatefulWidget {
  //const Search_Screen({ Key? key }) : super(key: key);

  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              filled: true,
            ),
          ),
        )
      ],
    );
  }
}
