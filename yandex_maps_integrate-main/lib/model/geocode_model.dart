final data = {
  [
    {
      "place_id": 278884100,
      "licence": "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
      "powered_by": "Map Maker: https://maps.co",
      "osm_type": "way",
      "osm_id": 922525288,
      "boundingbox": [
        "40.4220162",
        "40.451298",
        "70.5726466",
        "70.6476192"
      ],
      "lat": "40.4379858",
      "lon": "70.6039542",
      "display_name": "Beshariq, Beshariq Tumani, Fergana Region, 150300, Uzbekistan",
      "class": "place",
      "type": "city",
      "importance": 0.45999999999999996
    }
  ]
};

class GeoCodeModel {
  final int place_id;
  final String licence;
  final String powered_by;
  final String osm_type;
  final int osm_id;
  final List<String> boundingbox;
  final String lat;
  final String lon;
  final String display_name;
  final String clas;
  final String type;
  final double importance;

  GeoCodeModel({
    required this.place_id,
    required this.licence,
    required this.powered_by,
    required this.osm_type,
    required this.osm_id,
    required this.boundingbox,
    required this.lat,
    required this.lon,
    required this.display_name,
    required this.clas,
    required this.type,
    required this.importance,
  });

  factory GeoCodeModel.fromJson(Map<String, Object?> json){
    return GeoCodeModel(
        place_id: json['place_id'] as int,
        licence: json['licence'] as String,
        powered_by: json['powered_by'] as String,
        osm_type: json['osm_type'] as String,
        osm_id: json['osm_id'] as int,
        boundingbox: json['boundingbox'] as List<String>,
        lat: json['lat'] as String,
        lon: json['lon'] as String,
        display_name: json['display_name'] as String,
        clas: json['class'] as String,
        type: json['type'] as String,
        importance: json['importance'] as double,
    );
  }
}

