import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences_settings/shared_preferences_settings.dart';
import 'package:hive/hive.dart';

class Cache extends CacheProvider {
  get keys => getKeys();

  @override
  bool getBool(String key) {
    print('getter ===> key: $key from $keys');
    return _preferences.get(key);
  }

  @override
  double getDouble(String key) {
    print('getter ===> key: $key from $keys');
    return _preferences.get(key);
  }

  @override
  int getInt(String key) {
    print('getter ===> key: $key from $keys');
    return _preferences.get(key);
  }

  @override
  String getString(String key) {
    print('getter ===> key: $key from $keys');
    return _preferences.get(key);
  }

  @override
  Future<void> setBool(String key, bool value) {
    print('setter ===> key: $key value: $value');
    return _preferences.put(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) {
    print('setter ===> key: $key value: $value');
    return _preferences.put(key, value);
  }

  @override
  Future<void> setInt(String key, int value) {
    print('setter ===> key: $key value: $value');
    return _preferences.put(key, value);
  }

  @override
  Future<void> setString(String key, String value) {
    print('setter ===> key: $key value: $value');
    return _preferences.put(key, value);
  }

  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb) {
      Directory defaultDirectory = await getApplicationDocumentsDirectory();
      Hive.init(defaultDirectory.path);
    }
    _preferences = await Hive.openBox(keyName);
  }

  final String keyName = 'app_preferences';
  Box _preferences;

  @override
  bool containsKey(String key) {
    return _preferences.containsKey(key);
  }

  @override
  Set<E> getKeys<E>() {
    return _preferences.keys.cast<E>().toSet();
  }

  @override
  Future<void> remove(String key) async {
    if (containsKey(key)) {
      _preferences.delete(key);
    }
  }

  @override
  Future<void> removeAll() async {
    final keys = getKeys();
    _preferences.deleteAll(keys);
  }

  @override
  Future<Object> getValue(String settingsKey) {
    return _preferences.get(settingsKey);
  }
}
