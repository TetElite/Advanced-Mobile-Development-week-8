import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/rides_repository.dart';
import '../../states/ride_preferences_state.dart';
import 'ride_selection_content.dart';
import 'ride_selection_view_model.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RidesSelectionScreen extends StatefulWidget {
  const RidesSelectionScreen({super.key});

  @override
  State<RidesSelectionScreen> createState() => _RidesSelectionScreenState();
}

class _RidesSelectionScreenState extends State<RidesSelectionScreen> {
  late RideSelectionViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final ridePreferencesState = context.read<RidePreferencesState>();
    final ridesRepository = context.read<RidesRepository>();
    _viewModel = RideSelectionViewModel(ridePreferencesState, ridesRepository);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RideSelectionContent(viewModel: _viewModel);
  }
}
