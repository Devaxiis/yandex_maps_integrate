
import 'package:dio/dio.dart';
import 'package:yandex_maps_integrat/api/api.dart';
import 'package:yandex_maps_integrat/model/geocode_model.dart';

class NetworkService{

  final _dio = Dio();

  Future<List<GeoCodeModel>> searchCountry({String api = Api.searchApi,required Map<String,Object?> data})async{
     try{
       final response = await _dio.get(api,queryParameters: data);
       if(response.statusCode == 200 || response.statusCode == 201){
         List<String> data = response.data;
         List<GeoCodeModel> value = data.map((e) => GeoCodeModel.fromJson(e as Map<String,Object?>)).toList();
       return value;
       }
       return [GeoCodeModel(place_id: 999, licence: '', powered_by: '', osm_type: 'osm_type', osm_id: 9776, boundingbox: [], lat: 'lat', lon: 'lon', display_name: 'display_name', clas: 'clas', type: 'type', importance: 99999)];
     }catch (e){
       throw Exception("SearchCountryError:===>$e");
     }
  }

}