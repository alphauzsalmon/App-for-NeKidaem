import 'package:flutter/material.dart';
import 'package:ne_kidaem/card/constants/colors.dart';
import 'package:ne_kidaem/card/constants/size_config.dart';
import 'package:ne_kidaem/card/models/card.dart';
import 'package:ne_kidaem/card/screens/lists_page/lists_page.dart';
import 'package:ne_kidaem/language/app_localization.dart';


class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  AppBarWidget({Key? key})
      : preferredSize = Size.fromHeight(getHeight(100.0)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.transparent),
      title: Stack(
        children: [
          Padding(padding: EdgeInsets.only(
            left: getWidth(300.0),
            top: getHeight(0.0),
          ), child: IconButton(onPressed: () {
            Navigator.of(context).pop();
          },
            iconSize: getFont(30.0),
            icon: CircleAvatar(
              backgroundColor: cyanAccent,
              child: const Icon(Icons.arrow_back_rounded, color: Colors.white,),
            ),),),
          Padding(padding: EdgeInsets.only(
            top: getHeight(50.0),
          ),
            child: TabBar(
              physics: const ScrollPhysics(),
              controller: ListPageState.tabController,
              tabs: tabs(context),
              indicatorColor: cyanAccent,
              indicatorWeight: getFont(4.0),
              labelPadding: EdgeInsets.symmetric(
                horizontal: getWidth(5.0),
              ),
              labelStyle: TextStyle(
                  fontSize: getFont(15.0), fontWeight: FontWeight.bold, color: Colors.black),
            ),),
        ],
      ),
      backgroundColor: Colors.grey,
      toolbarHeight: getHeight(100.0),
      leadingWidth: getWidth(0.0),
    );
  }

  List<Text> tabs(context) {
    return [
      Text(AppLocalizations.of(context)!.translate('onHold')!),
      Text(AppLocalizations.of(context)!.translate('inProgress')!),
      Text(AppLocalizations.of(context)!.translate('needsReview')!),
      Text(AppLocalizations.of(context)!.translate('approved')!),
    ];
  }

  @override
  final Size preferredSize;
}

class Tabs extends StatelessWidget {
  Tabs({Key? key, required this.cards}) : super(key: key);
  List<List<OurCard>> cards;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: ListPageState.tabController,
      children: tabs());
  }

 List<Widget> tabs() {
    List<Widget> tabWidgets = [];
    for (var element in cards) {
      tabWidgets.add(
        ListView.builder(itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("ID: ${element[index].id}", style: TextStyle(fontSize: getFont(15.0),),),
              subtitle: Text(element[index].text!, style: TextStyle(fontSize: getFont(25.0),),),
            ),
          );
        }, itemCount: element.length,)
      );
    }
  return tabWidgets;
  }
}
