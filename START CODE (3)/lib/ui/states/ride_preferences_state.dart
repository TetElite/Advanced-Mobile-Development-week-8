import 'package:flutter/material.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../repositories/ride_preferences_repository.dart';

/// Global state manager for ride preferences.
/// Manages the current selected preference and preference history.
/// Notifies listeners when preferences change.
class RidePreferencesState extends ChangeNotifier {
  final RidePreferencesRepository _repository;

  RidePreference? _currentPreference;
  List<RidePreference> _preferenceHistory = [];

  static const int maxAllowedSeats = 8;

  RidePreferencesState(this._repository) {
    _initialize();
  }

  /// Get the currently selected ride preference.
  RidePreference? get currentPreference => _currentPreference;

  /// Get the history of ride preferences.
  List<RidePreference> get preferenceHistory => _preferenceHistory;

  /// Initialize by fetching preference history from repository.
  Future<void> _initialize() async {
    _preferenceHistory = await _repository.getPreferenceHistory();
    notifyListeners();
  }

  /// Select a new ride preference.
  /// Only updates if the preference differs from the current one.
  /// Adds the preference to history and notifies listeners.
  void selectPreference(RidePreference preference) {
    if (preference != _currentPreference) {
      // Set the selected preference
      _currentPreference = preference;

      // Push to history
      _addPreferenceToHistory(preference);

      // Notify listeners
      notifyListeners();
    }
  }

  /// Add a preference to the history.
  void _addPreferenceToHistory(RidePreference preference) {
    _preferenceHistory.add(preference);
  }
}
