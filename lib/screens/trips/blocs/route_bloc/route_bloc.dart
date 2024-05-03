import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trip_repository/trip_repository.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository _routeRepository;
  RouteBloc(this._routeRepository) : super(RouteInitial()) {
    on<CreateRoute>((event, emit) async {
      await _routeRepository.createRoute(
          event.tripId, event.coordinates, event.day, event.profile);
      emit(CreateRouteSuccess());
    });

    on<GetRoute>((event, emit) async {
      emit(GetRouteLoading());
      try {
        final TripRoute route = await _routeRepository.getRoute(
            event.tripId, event.day, event.profile);
        emit(GetRouteSuccess(route));
      } catch (e) {
        emit(GetRouteFailure());
      }
    });
  }
}