// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import FlutterMacOS
import Foundation

public class SharedPreferencesPlugin: NSObject, FlutterPlugin, UserDefaultsApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SharedPreferencesPlugin()
    UserDefaultsApiSetup.setUp(binaryMessenger: registrar.messenger, api: instance)
  }

  func getAll() -> [String? : Any?] {
    return getAllPrefs();
  }

  func setBool(key: String, value: Bool) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func setDouble(key: String, value: Double) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func setValue(key: String, value: Any) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func remove(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }

  func clear() {
    let defaults = UserDefaults.standard
    for (key, _) in getAllPrefs() {
      defaults.removeObject(forKey: key)
    }
  }
}

/// Returns all preferences stored by this plugin.
private func getAllPrefs() -> [String: Any] {
  var filteredPrefs: [String: Any] = [:]
  if let appDomain = Bundle.main.bundleIdentifier,
    let prefs = UserDefaults.standard.persistentDomain(forName: appDomain)
  {
    for (key, value) in prefs where key.hasPrefix("flutter.") {
      filteredPrefs[key] = value
    }
  }
  return filteredPrefs
}
