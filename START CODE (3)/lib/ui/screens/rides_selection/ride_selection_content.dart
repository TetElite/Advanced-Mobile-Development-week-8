import 'package:flutter/material.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../utils/animations_util.dart' show AnimationUtils;
import '../../theme/theme.dart';
import 'ride_selection_view_model.dart';
import 'widgets/ride_preference_modal.dart';
import 'widgets/rides_selection_header.dart';
import 'widgets/rides_selection_tile.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RideSelectionContent extends StatelessWidget {
  const RideSelectionContent({super.key, required this.viewModel});

  final RideSelectionViewModel viewModel;

  void onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  RidePreference get selectedRidePreference =>
      viewModel.selectedRidePreference!; // not null at this state

  void onPreferencePressed(BuildContext context) async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: selectedRidePreference),
          ),
        );

    if (newPreference != null) {
      // 2 - Ask the service to update the current preference
      viewModel.selectPreference(newPreference);

      // 3 -   Update the widget state  - TODO Improve this with proper state managagement
      // State updates are handled by the view model listeners.
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.selectedRidePreference == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'No ride preference selected.',
                style: BlaTextStyles.body,
              ),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              left: BlaSpacings.m,
              right: BlaSpacings.m,
              top: BlaSpacings.s,
            ),
            child: Column(
              children: [
                RideSelectionHeader(
                  ridePreference: selectedRidePreference,
                  onBackPressed: () => onBackTap(context),
                  onFilterPressed: onFilterPressed,
                  onPreferencePressed: () => onPreferencePressed(context),
                ),

                SizedBox(height: 100),

                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.matchingRides.length,
                    itemBuilder: (ctx, index) => RideSelectionTile(
                      ride: viewModel.matchingRides[index],
                      onPressed: () =>
                          onRideSelected(viewModel.matchingRides[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
