import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({Key? key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  final List<String> sugars = ["0", "1", "2", "3", "4"];
  final _formKey = GlobalKey<FormState>();

  String _currentName = '';
  String _currentSugar = '0';
  int _currentStrength = 100; // Initialize strength to a default value

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userdata = snapshot.data;
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Update your brew settings",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val) => setState(() => _currentName = val),
                      validator: (val) =>
                          val!.isEmpty ? "Please enter a name" : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField<String>(
                      value: _currentSugar,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem<String>(
                          value: sugar,
                          child: Text("$sugar Sugar"),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugar = val!),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Slider(
                      value: _currentStrength.toDouble(),
                      activeColor: Colors.brown[_currentStrength],
                      inactiveColor: Colors.brown[_currentStrength],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugar, _currentName, _currentStrength);
                        }
                        Navigator.pop(context);
                      },
                      label: const Text("Update"),
                      icon: const Icon(Icons.update),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        backgroundColor: Colors.brown[400],
                        foregroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
