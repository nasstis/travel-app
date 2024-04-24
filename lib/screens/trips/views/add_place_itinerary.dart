import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/screens/trips/blocs/trip_calendar_bloc.dart/trip_calendar_bloc.dart';
import 'package:trip_repository/trip_repository.dart';

class AddPlaceItinerary extends StatefulWidget {
  const AddPlaceItinerary({
    super.key,
    required this.extra,
  });

  final Map<String, dynamic>? extra;

  @override
  State<AddPlaceItinerary> createState() => _AddPlaceItineraryState();
}

class _AddPlaceItineraryState extends State<AddPlaceItinerary> {
  late List<bool> selectedCheckboxes;
  bool addPlacesRequired = false;
  late final DateTime date;
  late final Trip trip;

  @override
  void initState() {
    date = widget.extra!['date'];
    trip = widget.extra!['trip'];
    selectedCheckboxes = List.generate(trip.places.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<TripCalendarBloc, TripCalendarState>(
        listener: (context, state) {
          if (state is AddPlacesToItineraryFailure) {
            setState(() {
              addPlacesRequired = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is AddPlacesToItinerarySuccess) {
            setState(() {
              addPlacesRequired = false;
            });
            context.pop();
          }
          if (state is AddPlacesToItineraryLoading) {
            setState(() {
              addPlacesRequired = true;
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedCheckboxes.length,
                itemBuilder: (context, index) => Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              trip.places[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            leading: Container(
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      trip.places[index].photos[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            subtitle: trip.places[index].description != null
                                ? Text(
                                    trip.places[index].description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  )
                                : null,
                            isThreeLine: true,
                            visualDensity: const VisualDensity(vertical: 3),
                          ),
                        ),
                      ),
                      Checkbox(
                        value: selectedCheckboxes[index],
                        onChanged: (status) {
                          setState(() {
                            selectedCheckboxes[index] = status!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: addPlacesRequired
                    ? null
                    : () {
                        context.read<TripCalendarBloc>().add(
                              AddPlacesToItinerary(
                                  selectedCheckboxes: selectedCheckboxes,
                                  trip: widget.extra!['trip'],
                                  date: date.toString()),
                            );
                      },
                child: addPlacesRequired
                    ? const CircularProgressIndicator()
                    : const Text('Add places to Itinerary'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
