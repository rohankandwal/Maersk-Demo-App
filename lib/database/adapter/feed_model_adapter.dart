import 'package:demo/feed_model.dart';
import 'package:hive/hive.dart';

class FeedModelAdapter extends TypeAdapter<FeedModel> {
  @override
  final typeId = 0;

  @override
  FeedModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[3] as String,
      mediaPath: fields[4] as String,
      isFavorite: fields[5] as int,
      isLiked: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FeedModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.mediaPath)
      ..writeByte(4)
      ..write(obj.isLiked)
      ..writeByte(5)
      ..write(obj.isFavorite);
  }
}
