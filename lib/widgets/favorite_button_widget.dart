import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      child: Icon(Icons.favorite_border_outlined),
    );
  }
}
