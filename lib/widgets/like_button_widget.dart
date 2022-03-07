import 'package:flutter/material.dart';

class LikeButtonWidget extends StatefulWidget {
  const LikeButtonWidget({Key? key}) : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      child: Icon(Icons.thumb_up_alt_outlined),
    );
  }
}
