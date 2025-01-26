import 'package:firbase_nextpak_demo_test/src/common/constants/global_variables.dart';
import 'package:firbase_nextpak_demo_test/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/shared_preferences_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Fetch user data using SharedPreferencesHelper
    name = await SharedPreferencesHelper.getString('name');
    email = await SharedPreferencesHelper.getString('email');
    setState(() {});
  }

  Future<void> _logout(BuildContext context) async {
    // Clear all saved preferences
    await SharedPreferencesHelper.clearAll();

    // Ensure the widget tree is fully rebuilt before navigating
    if (mounted) {
      setState(() {
        name = null;
        email = null;
      });
    }

    // Navigate to login page
    context.pushReplacementNamed(
        AppRoute.login); // Use `pushReplacementNamed` to avoid stacking
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onSurface,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onSurface,
        title: Text(
          'Home Page',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: colorScheme(context).surface),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: colorScheme(context).surface,
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: name != null && email != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, $name!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme(context).surface, fontSize: 20),
                  ),
                  Text(
                    'Email: $email',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme(context).surface, fontSize: 16),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
