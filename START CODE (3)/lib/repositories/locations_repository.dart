import '../model/ride/locations.dart';

/// Abstract repository interface for location data access.
/// Defines contracts for fetching available locations.
abstract class LocationsRepository {
  /// Fetch all available locations.
  Future<List<Location>> getAvailableLocations();
}
