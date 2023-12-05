import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yandex_maps_integrat/data/network_service.dart';
import 'package:yandex_maps_integrat/services/service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchBarEvent>(_searchBar);
  }
  
  void _searchBar (SearchBarEvent event,Emitter emit)async{
    emit(SearchLoading());

    Map<String,Object?>daat = {
      'q':event.text
    };
    final repo = await NetworkService().searchCountry(data: daat);
    print("<=====>${repo[0].display_name}<=====>");
    emit(SearchSuccess());
  }
}
