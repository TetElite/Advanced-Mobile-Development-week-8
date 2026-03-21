import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/ride_preferences_state.dart';
import 'home_content.dart';
import 'home_view_model.dart';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final ridePreferencesState = context.read<RidePreferencesState>();
    _viewModel = HomeViewModel(ridePreferencesState);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContent(viewModel: _viewModel);
  }
}
