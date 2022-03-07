import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class FeedModel extends HiveObject {
  final int id;
  final String title;
  final String description;
  final String mediaPath;
  final int isLiked;
  final int isFavorite;

  FeedModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.mediaPath,
      this.isLiked = 0,
      this.isFavorite = 0}); // 0 means false, 1 is true

}
