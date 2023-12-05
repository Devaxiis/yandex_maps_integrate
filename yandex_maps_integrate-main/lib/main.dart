import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_maps_integrat/bloc/search/search_bloc.dart';
import 'package:yandex_maps_integrat/screen/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MapScreen(),
      ),
    );
  }
}
