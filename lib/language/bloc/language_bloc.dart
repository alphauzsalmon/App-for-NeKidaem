import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ne_kidaem/card/constants/hive.dart';
import 'package:ne_kidaem/language/models/language.dart';
import 'package:flutter/material.dart';
part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageLoaded(Locale(Languages.languages[lanBox!.get('language')].code))) {
    on<ToggleLanguageEvent>(mapEvent);
  }


  mapEvent(
      ToggleLanguageEvent event, Emitter<LanguageState> emit) async {
    if (event is ToggleLanguageEvent) {
      await lanBox!.clear();
      await lanBox!.put('language', event.index);
      emit(LanguageLoaded(Locale(Languages.languages[event.index].code)));
    }
  }
}
