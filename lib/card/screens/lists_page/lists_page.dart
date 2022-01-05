import 'package:flutter/material.dart';
import 'package:ne_kidaem/card/models/card.dart';
import 'package:ne_kidaem/card/screens/lists_page/lists_page_widgets.dart';

class ListsPage extends StatefulWidget {
  ListsPage({Key? key, required this.data}) : super(key: key);
  List<OurCard> data;

  @override
  State<StatefulWidget> createState() => ListPageState();
}

class ListPageState extends State<ListsPage>
    with SingleTickerProviderStateMixin {
  static late TabController tabController;
  late int rowLen;
  List<List<OurCard>> cards = [];

  @override
  void initState() {
    rowLen = int.parse(widget.data.last.row!) + 1;
    tabController = TabController(length: rowLen, vsync: this);
    for(int i = 0; i < rowLen; i++) {
      cards.insert(i, []);
    }
    for (int i = 0; i < widget.data.length; i++) {
      for (int j = 0; j < rowLen; j++) {
        if (j == int.parse(widget.data[i].row!)) {
          cards[j].add(widget.data[i]);
          break;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Tabs(cards: cards,),
    );
  }
}
