import '../../data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../rides_repository.dart';

/// Mock implementation of RidesRepository using fake data.
class MockRidesRepository implements RidesRepository {
  @override
  Future<List<Ride>> getAllRides() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));
    return fakeRides;
  }
}
