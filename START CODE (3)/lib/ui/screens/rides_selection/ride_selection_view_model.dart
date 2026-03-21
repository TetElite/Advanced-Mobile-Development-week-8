import 'package:flutter/material.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../repositories/rides_repository.dart';
import '../../states/ride_preferences_state.dart';

/// ViewModel for the Ride Selection screen.
/// Handles ride loading and filtering based on current ride preferences.
class RideSelectionViewModel extends ChangeNotifier {
  final RidePreferencesState _ridePreferencesState;
  final RidesRepository _ridesRepository;

  List<Ride> _allRides = [];
  List<Ride> _matchingRides = [];

  RideSelectionViewModel(this._ridePreferencesState, this._ridesRepository) {
    _ridePreferencesState.addListener(_onRidePreferencesStateChanged);
    _initialize();
  }

  RidePreference? get selectedRidePreference =>
      _ridePreferencesState.currentPreference;

  List<Ride> get matchingRides => _matchingRides;

  Future<void> _initialize() async {
    _allRides = await _ridesRepository.getAllRides();
    _computeMatchingRides();
    notifyListeners();
  }

  void selectPreference(RidePreference preference) {
    _ridePreferencesState.selectPreference(preference);
  }

  void _onRidePreferencesStateChanged() {
    _computeMatchingRides();
    notifyListeners();
  }

  void _computeMatchingRides() {
    final preference = selectedRidePreference;
    if (preference == null) {
      _matchingRides = [];
      return;
    }

    _matchingRides = _allRides
        .where(
          (ride) =>
              ride.departureLocation == preference.departure &&
              ride.arrivalLocation == preference.arrival &&
              ride.availableSeats >= preference.requestedSeats,
        )
        .toList();
  }

  @override
  void dispose() {
    _ridePreferencesState.removeListener(_onRidePreferencesStateChanged);
    super.dispose();
  }
}
