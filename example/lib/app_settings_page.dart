import 'package:flutter/material.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SettingsScreen(
        title: "Application Settings",
        children: [
          CheckboxSettingsTile(
            settingKey: 'key-of-your-setting',
            title: 'This is a simple Checkbox',
          ),
          SwitchSettingsTile(
            settingKey: 'key-of-your-setting-2',
            title: 'This is a Switch',
          ),
        ],
      ),
    );
  }
}
