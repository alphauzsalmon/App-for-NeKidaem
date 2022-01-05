import 'package:hive/hive.dart';
import 'package:ne_kidaem/card/models/card.dart';

Box? boxUser;
Box<OurCard>? cardBox;
Box? lanBox;

openHiveBox() async {
  if (boxUser != null) {
    if (!boxUser!.isOpen) {
      boxUser = await Hive.openBox('myUser');
    }
  }
  else {
    boxUser = await Hive.openBox('myUser');
  }

  if (lanBox != null) {
    if (lanBox!.isOpen) {
      lanBox = await Hive.openBox('languageBox');
    }
  }
  else {
    lanBox = await Hive.openBox('languageBox');
  }

  if (lanBox!.isEmpty) {
    await lanBox!.put('language', 0);
  }

  if (cardBox != null) {
    if (!cardBox!.isOpen) {
      cardBox = await Hive.openBox<OurCard>('myStorage');
    }
  }
  else {
    cardBox = await Hive.openBox<OurCard>('myStorage');
  }
}

