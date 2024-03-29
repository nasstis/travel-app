import 'dart:developer';

import 'package:city_repository/city_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCityRepo implements CityRepo {
  final cityColection = FirebaseFirestore.instance.collection('cities');

  @override
  Future<List<City>> getCities() async {
    try {
      return await cityColection.get().then((value) => value.docs
          .map(
            (e) => City.fromEntity(
              CityEntity.fromDocument(e.data()),
            ),
          )
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<City>?> getSearchResult({required String qSearch}) async {
    String newVal =
        qSearch[0].toUpperCase() + qSearch.substring(1).toLowerCase();
    log(newVal);
    final city = await cityColection
        .where('name', isGreaterThanOrEqualTo: newVal)
        .where('name', isLessThanOrEqualTo: '$newVal\uf8ff')
        .get();

    log(city.docs.toString());

    List<City> cities = city.docs
        .map(
          (e) => City.fromEntity(
            CityEntity.fromDocument(e.data()),
          ),
        )
        .toList();
    return cities;
  }
}
