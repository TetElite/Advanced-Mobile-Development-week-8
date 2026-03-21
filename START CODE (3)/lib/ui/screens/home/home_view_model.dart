import 'package:flutter/material.dart';

import '../../../model/ride_pref/ride_pref.dart';
import '../../states/ride_preferences_state.dart';

/// ViewModel for the Home screen.
/// Manages home screen state by listening to global RidePreferencesState.
class HomeViewModel extends ChangeNotifier {
  final RidePreferencesState _ridePreferencesState;

  HomeViewModel(this._ridePreferencesState) {
    _ridePreferencesState.addListener(_onRidePreferencesStateChanged);
  }

  /// Get the current ride preference.
  RidePreference? get currentPreference =>
      _ridePreferencesState.currentPreference;

  /// Get the history of ride preferences.
  List<RidePreference> get preferenceHistory =>
      _ridePreferencesState.preferenceHistory;

  /// Called when RidePreferencesState changes.
  void _onRidePreferencesStateChanged() {
    notifyListeners();
  }

  /// Update the selected ride preference.
  void selectPreference(RidePreference preference) {
    _ridePreferencesState.selectPreference(preference);
  }

  @override
  void dispose() {
    _ridePreferencesState.removeListener(_onRidePreferencesStateChanged);
    super.dispose();
  }
}
