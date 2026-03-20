import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/locations_repository.dart';
import 'repositories/mock/mock_locations_repository.dart';
import 'repositories/mock/mock_ride_preferences_repository.dart';
import 'repositories/mock/mock_rides_repository.dart';
import 'repositories/ride_preferences_repository.dart';
import 'repositories/rides_repository.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const BlaBlaApp());
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LocationsRepository>(create: (_) => MockLocationsRepository()),
        Provider<RidesRepository>(create: (_) => MockRidesRepository()),
        Provider<RidePreferencesRepository>(
          create: (_) => MockRidePreferencesRepository(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: blaTheme,
        home: Scaffold(body: HomeScreen()),
      ),
    );
  }
}
