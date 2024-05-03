import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/trips/blocs/route_bloc/route_bloc.dart';
import 'package:travel_app/utils/constants/colors.dart';

import '../../city/views/map_view.dart';

class ItineraryMap extends StatelessWidget {
  const ItineraryMap({super.key, required this.places});

  final List places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.light.withOpacity(0.5),
      ),
      body: BlocBuilder<RouteBloc, RouteState>(
        builder: (context, state) {
          if (state is GetRouteSuccess) {
            return Stack(
              children: [
                MapView(
                  latLng: LatLng(places[0].latitude, places[0].longitude),
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  places: places,
                  isItinerary: true,
                  polyline: state.route.geometry,
                  polylines: state.route.legs[0].geometry,
                ),
                Positioned(
                  top: 120,
                  left: 135,
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    elevation: 7,
                    child: Container(
                      width: 140,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          '${(state.route.distance / 1000).toStringAsFixed(1)} km, ${(state.route.duration / 60).toStringAsFixed(0)} mins',
                          style: const TextStyle(
                            fontSize: 14,
                            color: MyColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.light.withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<RouteBloc>().add(
                                  GetRoute(state.route.tripId, state.route.day,
                                      'cycling'),
                                );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.personBiking,
                            color: state.route.profile == 'cycling'
                                ? MyColors.primary
                                : null,
                            size: state.route.profile == 'cycling' ? 28 : null,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<RouteBloc>().add(
                                  GetRoute(state.route.tripId, state.route.day,
                                      'walking'),
                                );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.personWalking,
                            color: state.route.profile == 'walking'
                                ? MyColors.primary
                                : null,
                            size: state.route.profile == 'walking' ? 30 : null,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<RouteBloc>().add(
                                  GetRoute(state.route.tripId, state.route.day,
                                      'driving'),
                                );
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.car,
                            color: state.route.profile == 'driving'
                                ? MyColors.primary
                                : null,
                            size: state.route.profile == 'driving' ? 28 : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          if (state is GetRouteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center();
        },
      ),
    );
  }
}
