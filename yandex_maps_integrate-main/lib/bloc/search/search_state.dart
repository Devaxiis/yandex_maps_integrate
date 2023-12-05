part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}
class SearchFailure extends SearchState {
  @override
  List<Object> get props => [];
}
class SearchSuccess extends SearchState {
  @override
  List<Object> get props => [];
}