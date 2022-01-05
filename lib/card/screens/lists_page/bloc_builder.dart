import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ne_kidaem/card/bloc/card_bloc.dart';
import 'package:ne_kidaem/card/constants/hive.dart';
import 'package:ne_kidaem/card/screens/lists_page/lists_page.dart';
import '../../../cards_repository.dart';

class BlocBuilderWidget extends StatelessWidget {
  const BlocBuilderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CardBloc(SampleCardsRepository())..add(const CardsStarted()),
      child: BlocBuilder<CardBloc, CardsState>(builder: (context, state) {
      if (state is CardsError) {
        return AlertDialogWidget(text: state.message.toString());
      } else if (state is CardsUnAuthorized) {
        return AlertDialogWidget(text: state.message.toString());
      } else if (state is CardsCompleted) {
          cardBox!.addAll(state.response);
          return ListsPage(data: state.response);
      } else {
        return const CircularScaffoldWidget();
      }
    }),);
  }
}

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}

class CircularScaffoldWidget extends StatelessWidget {
  const CircularScaffoldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.cyanAccent,
        ),
      ),
    );
  }
}