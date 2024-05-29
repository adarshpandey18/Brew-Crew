import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return const SettingsPanel();
      });
    }
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return const Loading();
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user.uid).brews,
      initialData: [], // Set initialData to null
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          actions: [
            TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              icon: const Icon(Icons.person, color: Colors.black),
            ),
            TextButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              label: const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
