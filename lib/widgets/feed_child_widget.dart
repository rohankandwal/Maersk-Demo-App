import 'package:demo/feed_model.dart';
import 'package:demo/widgets/favorite_button_widget.dart';
import 'package:demo/widgets/like_button_widget.dart';
import 'package:flutter/material.dart';

class FeedChildWidget extends StatefulWidget {
  final FeedModel feedModel;

  const FeedChildWidget({Key? key, required this.feedModel}) : super(key: key);

  @override
  State<FeedChildWidget> createState() => _FeedChildWidgetState();
}

class _FeedChildWidgetState extends State<FeedChildWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle(),
            _getDescription(),
            const SizedBox(
              height: 8,
            ),
            _getImage(),
            const SizedBox(
              height: 8,
            ),
            _getLikeAndFavoriteRow(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Text(
      widget.feedModel.title,
      style: TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  Widget _getDescription() {
    return Text(
      widget.feedModel.description,
      style: TextStyle(color: Colors.black, fontSize: 14),
    );
  }

  Widget _getImage() {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.red,
    );
  }

  Widget _getLikeAndFavoriteRow() {
    return Row(
      children: [
        _getLikeButton(),
        const SizedBox(
          width: 10,
        ),
        _getFavoriteButton(),
      ],
    );
  }

  Widget _getLikeButton() {
    return const LikeButtonWidget();
  }

  Widget _getFavoriteButton() {
    return const FavoriteButtonWidget();
  }
}
