import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class OurCard extends HiveObject {
  OurCard({
    this.id,
    this.row,
    this.seqNum,
    this.text,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? row;
  @HiveField(2)
  int? seqNum;
  @HiveField(3)
  String? text;

  factory OurCard.fromJson(Map<String, dynamic> json) => OurCard(
    id: json["id"],
    row: json["row"],
    seqNum: json["seq_num"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "row": row,
    "seq_num": seqNum,
    "text": text,
  };
}


class OurCardAdapter extends TypeAdapter<OurCard> {
  @override
  OurCard read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OurCard(
      id: fields[0] as int,
      row: fields[1] as String,
      seqNum: fields[2] as int,
      text: fields[3] as String,
    );
  }

  @override
  final typeId = 0;

  @override
  void write(BinaryWriter writer, OurCard obj) {
    writer
        ..writeByte(4)
        ..writeByte(0)
        ..write(obj.id)
        ..writeByte(1)
        ..write(obj.row)
        ..writeByte(2)
        ..write(obj.seqNum)
        ..writeByte(3)
        ..write(obj.text);
  }
}

