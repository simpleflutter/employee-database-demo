import 'package:flutter/material.dart';

class JumpToPage {
  static push(BuildContext context, Widget page) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }
}
