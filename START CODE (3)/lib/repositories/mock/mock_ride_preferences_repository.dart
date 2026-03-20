import '../../model/ride_pref/ride_pref.dart';
import '../ride_preferences_repository.dart';

/// Mock implementation of RidePreferencesRepository using fake data.
class MockRidePreferencesRepository implements RidePreferencesRepository {
  @override
  Future<List<RidePreference>> getPreferenceHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    // Start with an empty history — it will be populated as user selects preferences
    return [];
  }
}
