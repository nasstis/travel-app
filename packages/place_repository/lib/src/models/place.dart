import 'package:place_repository/place_repository.dart';

class Place {
  String id;
  String name;
  List<dynamic> types;
  double latitude;
  double longitude;
  String address;
  List reviews;
  List<dynamic> photos;
  String cityId;
  String? description;
  String? businessStatus;
  double? rating;
  bool? goodForChildren;
  List<dynamic>? openingHours;
  bool? restroom;

  Place({
    required this.id,
    required this.name,
    required this.types,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.reviews,
    required this.photos,
    required this.cityId,
    this.description,
    this.businessStatus,
    this.rating,
    this.goodForChildren,
    this.openingHours,
    this.restroom,
  });

  // PlaceEntity toEntity() {
  //   return PlaceEntity(
  //     id: id,
  //     name: name,
  //     types: types,
  //     description: description,
  //     pictures: pictures,
  //     latitude: latitude,
  //     longitude: longitude,
  //     cityId: cityId,
  //     address: address,
  //   );
  // }

  static Place fromEntity(PlaceEntity entity) {
    return Place(
      id: entity.id,
      name: entity.name,
      types: entity.types,
      latitude: entity.latitude,
      longitude: entity.longitude,
      address: entity.address,
      reviews: entity.reviews,
      photos: entity.photos,
      cityId: entity.cityId,
      description: entity.description,
      businessStatus: entity.businessStatus,
      rating: entity.rating,
      goodForChildren: entity.goodForChildren,
      openingHours: entity.openingHours,
      restroom: entity.restroom,
    );
  }
}
