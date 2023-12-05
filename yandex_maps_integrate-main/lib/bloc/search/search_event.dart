part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchBarEvent extends SearchEvent{
  String text;

  SearchBarEvent({required this.text});

  @override
  List<Object?> get props => [];

}
