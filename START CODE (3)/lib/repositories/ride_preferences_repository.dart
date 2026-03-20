import '../model/ride_pref/ride_pref.dart';

/// Abstract repository interface for ride preference data access.
/// Defines contracts for fetching and managing ride preference history.
abstract class RidePreferencesRepository {
  /// Fetch the history of ride preferences.
  Future<List<RidePreference>> getPreferenceHistory();
}
