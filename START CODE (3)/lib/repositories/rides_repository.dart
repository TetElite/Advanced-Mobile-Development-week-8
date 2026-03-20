import '../model/ride/ride.dart';

/// Abstract repository interface for ride data access.
/// Defines contracts for fetching rides.
abstract class RidesRepository {
  /// Fetch all available rides.
  Future<List<Ride>> getAllRides();
}
