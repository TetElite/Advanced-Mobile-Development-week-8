import 'package:flutter/material.dart';

import '../../../model/ride_pref/ride_pref.dart';
import '../../../utils/animations_util.dart';
import '../../theme/theme.dart';
import '../../widgets/pickers/bla_ride_preference_picker.dart';
import '../rides_selection/rides_selection_screen.dart';
import 'home_view_model.dart';
import 'widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

/// Content widget for the Home screen.
/// Stateless widget that displays the home UI and responds to ViewModel changes.
class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  void onRidePrefSelected(
    RidePreference selectedPreference,
    BuildContext context,
  ) async {
    // 1- Ask the view model to update the current preference
    viewModel.selectPreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(
      context,
    ).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));

    // 3 - After wait  - The view model will notify listeners on return
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Stack(children: [_buildBackground(), _buildForeground(context)]);
      },
    );
  }

  Widget _buildForeground(BuildContext context) {
    return Column(
      children: [
        // 1 - THE HEADER
        SizedBox(height: 16),
        Align(
          alignment: AlignmentGeometry.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(height: 100),

        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: viewModel.currentPreference,
                onRidePreferenceSelected: (pref) =>
                    onRidePrefSelected(pref, context),
              ),
              SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context) {
    // Reverse the history of preferences
    List<RidePreference> history = viewModel.preferenceHistory.reversed
        .toList();
    return SizedBox(
      height: 200, // Set a fixed height
      child: ListView.builder(
        shrinkWrap: true, // Fix ListView height issue
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => onRidePrefSelected(history[index], context),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
