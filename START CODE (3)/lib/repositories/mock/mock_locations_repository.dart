import '../../data/dummy_data.dart';
import '../../model/ride/locations.dart';
import '../locations_repository.dart';

/// Mock implementation of LocationsRepository using fake data.
class MockLocationsRepository implements LocationsRepository {
  @override
  Future<List<Location>> getAvailableLocations() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    return fakeLocations;
  }
}
