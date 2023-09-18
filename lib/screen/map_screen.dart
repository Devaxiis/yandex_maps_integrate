
import 'dart:async';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:flutter/material.dart';
import 'package:yandex_maps_integrat/model/map_model.dart';
import 'package:yandex_maps_integrat/services/service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();

/*
_initPermission() usuli foydalanuvchi ruxsat berganligini tekshiradi
geolokatsiyani aniqlash. Agar taqdim etilmasa, biz ruxsat olish uchun so'rov yuboramiz
geolokatsiyaga kirish. Shundan so'ng biz _fetchCurrentLocation() usulini chaqiramiz
muvofiqlashtirish sozlamalari.
 */
  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  /*
  _initPermission().ignore() orqali ruxsat soʻrash va MapScreen initState() da koordinatalarni oʻrnatish va amalga oshirish tayyor.
.ignore() bu yerda xavfsiz ishlash va Future _initPermission() usuliga e'tibor bermaslik uchun kerak
   */

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        onMapCreated: (controller) {
          mapControllerCompleter.complete(controller);
        },
      ),
    );
  }

/*
_fetchCurrentLocation() usuli usul uchun kerakli koordinatalarni oladi
_moveToCurrentPosition(). Xato bo'lsa yoki u aniqlay olmasa
hozirgi joylashuvi, Toshkent koordinatalarini qaytaradi.
 */
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

/*
_moveToCurrentPosition() usulini yozamiz. Bu asosiy usul bo'ladi
foydalanuvchining joylashuvini xaritada ko'rsatish:
 */

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
    (await mapControllerCompleter.future).moveCamera(
        animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
        CameraUpdate.newCameraPosition(CameraPosition(
          target: Point(latitude: appLatLong.lat, longitude: appLatLong.long),
          zoom: 12,
        )));
  }
/*
 Usul biz yuqorida olgan balandlik va kenglik koordinatalarini qabul qiladi.
Biz mapControllerCompleter va undan keyingi usullardan foydalanishni kutamiz
Qabul qilingan koordinatalar bo'yicha .moveCamera() va .newCameraPosition()
fokusni animatsion tarzda joriy joyga ko'chiring.
Masshtab parametri: 12 masofani yaqinroq/uzoqroq qilib belgilaydi, shuning uchun siz ko'rsatishingiz mumkin
aniqroq joylashuv koordinatalari.
   */
}


