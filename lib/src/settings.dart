import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'cache.dart';

class Settings {
  static final Settings _instance = Settings._internal();

  factory Settings() {
    assert(
        _cacheProvider != null,
        'Must call Settings.init(cacheProvider)'
        ' before using settings!');
    return _instance;
  }

  Settings._internal();

  static CacheProvider _cacheProvider;

  static void init(CacheProvider cacheProvider) {
    _cacheProvider = cacheProvider;
  }

  //

  Map<String, _SettingStream<int>> _intStreams =
      Map<String, _SettingStream<int>>();

  _SettingStream _getIntStreamOf(String settingKey) {
    print('settingsKey: $settingKey int streams: $_intStreams');
    if (_intStreams.containsKey(settingKey)) {
      return _intStreams[settingKey];
    }
    _SettingStream<int> stream = _SettingStream<int>();
    _intStreams[settingKey] = stream;
    return stream;
  }

  StreamBuilder<int> onIntChanged({
    @required String settingKey,
    @required int defaultValue,
    @required Function childBuilder,
  }) {
    return StreamBuilder<int>(
      stream: _getIntStreamOf(settingKey).stream,
      initialData: defaultValue,
      builder: (context, snapshot) {
        return childBuilder(context, snapshot.data);
      },
    );
  }

  void _intChanged(String settingKey, int value) {
    if (_intStreams.containsKey(settingKey)) {
      _intStreams[settingKey].push(value);
    }
  }

  //

  Map<String, _SettingStream<bool>> _boolStreams =
      Map<String, _SettingStream<bool>>();

  _SettingStream _getBoolStreamOf(String settingKey) {
    print('settingsKey: $settingKey bool streams: $_boolStreams');
    if (_boolStreams.containsKey(settingKey)) {
      return _boolStreams[settingKey];
    }
    _SettingStream<bool> stream = _SettingStream<bool>();
    _boolStreams[settingKey] = stream;
    return stream;
  }

  StreamBuilder<bool> onBoolChanged({
    @required String settingKey,
    @required bool defaultValue,
    @required Function childBuilder,
  }) {
    return StreamBuilder<bool>(
      stream: _getBoolStreamOf(settingKey).stream,
      initialData: defaultValue,
      builder: (context, snapshot) {
        return childBuilder(context, snapshot.data);
      },
    );
  }

  void _boolChanged(String settingKey, bool value) {
    if (_boolStreams.containsKey(settingKey)) {
      _boolStreams[settingKey].push(value);
    }
  }

  //

  Map<String, _SettingStream<String>> _stringStreams =
      Map<String, _SettingStream<String>>();

  _SettingStream _getStringStreamOf(String settingKey) {
    print('settingsKey: $settingKey string streams: $_stringStreams');
    if (_stringStreams.containsKey(settingKey)) {
      return _stringStreams[settingKey];
    }
    _SettingStream<String> stream = _SettingStream<String>();
    _stringStreams[settingKey] = stream;
    return stream;
  }

  StreamBuilder<String> onStringChanged({
    @required String settingKey,
    @required String defaultValue,
    @required Function childBuilder,
  }) {
    return StreamBuilder<String>(
      stream: _getStringStreamOf(settingKey).stream,
      initialData: defaultValue,
      builder: (context, snapshot) {
        return childBuilder(context, snapshot.data);
      },
    );
  }

  void _stringChanged(String settingKey, String value) {
    if (_stringStreams.containsKey(settingKey)) {
      _stringStreams[settingKey].push(value);
    }
  }

  //

  Map<String, _SettingStream<double>> _doubleStreams =
      Map<String, _SettingStream<double>>();

  _SettingStream _getDoubleStreamOf(String settingKey) {
    print('settingsKey: $settingKey double streams: $_doubleStreams');
    if (_doubleStreams.containsKey(settingKey)) {
      return _doubleStreams[settingKey];
    }
    _SettingStream<double> stream = _SettingStream<double>();
    _doubleStreams[settingKey] = stream;
    return stream;
  }

  StreamBuilder<double> onDoubleChanged({
    @required String settingKey,
    @required double defaultValue,
    @required Function childBuilder,
  }) {
    return StreamBuilder<double>(
      stream: _getDoubleStreamOf(settingKey).stream,
      initialData: defaultValue,
      builder: (context, snapshot) {
        return childBuilder(context, snapshot.data);
      },
    );
  }

  void _doubleChanged(String settingKey, double value) {
    if (_doubleStreams.containsKey(settingKey)) {
      _doubleStreams[settingKey].push(value);
    }
  }

  //

  Future<int> getInt(String key, int defaultValue) async {
    return _cacheProvider.getInt(key) as int ?? defaultValue;
  }

  Future<String> getString(String key, String defaultValue) async {
    return _cacheProvider.getString(key) as String ?? defaultValue;
  }

  Future<double> getDouble(String key, double defaultValue) async {
    return _cacheProvider.getDouble(key) as double ?? defaultValue;
  }

  Future<bool> getBool(String key, bool defaultValue) async {
    return _cacheProvider.getBool(key) as bool ?? defaultValue;
  }

  void pingString(String key, String defaultValue) async {
    final String value = await getString(key, defaultValue);
    _stringChanged(key, value);
  }

  void pingDouble(String key, double defaultValue) async {
    final double value = await getDouble(key, defaultValue);
    _doubleChanged(key, value);
  }

  void pingBool(String key, bool defaultValue) async {
    final bool value = await getBool(key, defaultValue);
    _boolChanged(key, value);
  }

  void save(String key, dynamic value) async {
    if (value is int) {
      await _cacheProvider.setInt(key, value);
      _intChanged(key, value);
    } else if (value is String) {
      await _cacheProvider.setString(key, value);
      _stringChanged(key, value);
    } else if (value is double) {
      await _cacheProvider.setDouble(key, value);
      _doubleChanged(key, value);
    } else if (value is bool) {
      await _cacheProvider.setBool(key, value);
      _boolChanged(key, value);
    }
  }

  bool containsKey(String key) {
    final status = _cacheProvider.containsKey(key);
    return status;
  }

  Object getValue(String settingsKey) {
    return _cacheProvider.getValue(settingsKey);
  }
}

class _SettingStream<T> {
  final BehaviorSubject<T> _subject = BehaviorSubject<T>();

  Stream<T> get stream => _subject.stream;

  void push(T data) {
    _subject.add(data);
  }
}
