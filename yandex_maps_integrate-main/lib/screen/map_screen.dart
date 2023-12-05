import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter/material.dart';
import 'package:yandex_maps_integrat/bloc/search/search_bloc.dart';
import 'package:yandex_maps_integrat/model/map_model.dart';
import 'package:yandex_maps_integrat/services/service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();

  TextEditingController controller = TextEditingController();

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }


  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Container(
            height: 50,
            width: MediaQuery
                .sizeOf(context)
                .width * 0.70,
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Qidirish...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey
                      )
                  )
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle
                ),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return IconButton(onPressed: () {
                      context.read<SearchBloc>().add(
                          SearchBarEvent(text: controller.text.trim()));
                    }, icon: const Icon(Icons.search, color: Colors.black,));
                  },
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: SafeArea(
          child: YandexMap(
            onMapCreated: (controller) {
              mapControllerCompleter.complete(controller);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = TashkentLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
    (await mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: appLatLong.lat, longitude: appLatLong.long),
          zoom: 15,
        ),
      ),

    );
  }
}


