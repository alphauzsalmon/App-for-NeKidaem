part of 'language_bloc.dart';

abstract class LanguageEvent {}

class ToggleLanguageEvent extends LanguageEvent {
  final int index;
  ToggleLanguageEvent(this.index);
}