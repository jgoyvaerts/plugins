// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'image_format_group.dart';

/// The direction the camera is facing.
enum CameraLensDirection {
  /// Front facing camera (a user looking at the screen is seen by the camera).
  front,

  /// Back facing camera (a user looking at the screen is not seen by the camera).
  back,

  /// External camera which may not be mounted to the device.
  external,
}

/// Properties of a camera device.
@immutable
class CameraDescription {
  /// Creates a new camera description with the given properties.
  const CameraDescription({
    required this.name,
    required this.lensDirection,
    required this.sensorOrientation,
    required this.supportedOutputFormats,
  });

  /// The name of the camera device.
  final String name;

  /// The direction the camera is facing.
  final CameraLensDirection lensDirection;

  /// Clockwise angle through which the output image needs to be rotated to be upright on the device screen in its native orientation.
  ///
  /// **Range of valid values:**
  /// 0, 90, 180, 270
  ///
  /// On Android, also defines the direction of rolling shutter readout, which
  /// is from top to bottom in the sensor's coordinate system.
  final int sensorOrientation;

  /// A list of all output formats supported by this camera
  final List<OutputFormat> supportedOutputFormats;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraDescription &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          lensDirection == other.lensDirection;

  @override
  int get hashCode => Object.hash(name, lensDirection);

  @override
  String toString() {
    return '${objectRuntimeType(this, 'CameraDescription')}('
        '$name, $lensDirection, $sensorOrientation)';
  }
}

/// Supported output formats of a camera device

class OutputFormat {
  /// Creates a new OutputFormat with the given properties
  OutputFormat({
    required this.format,
    required this.width,
    required this.height,
  }) : aspectRatio = _calculateAspectRatio(width, height);

  /// The image format of this OutputFormat, for example ImageFormatGroup.jpeg
  final ImageFormatGroup format;

  /// The width of this OutputFormat
  final int width;

  /// The height of this OutputFormat
  final int height;

  /// The aspect ratio of this OutputFormat
  final OuputAspectRatio aspectRatio;

  static OuputAspectRatio _calculateAspectRatio(int width, int height) {
    if (width == height) {
      return OuputAspectRatio.one_one;
    }
    if ((width / 4) * 3 == height) {
      return OuputAspectRatio.four_three;
    }
    if ((width / 16) * 9 == height) {
      return OuputAspectRatio.sixteen_nine;
    }
    return OuputAspectRatio.unknown;
  }
}

/// The aspect ratio of the outputformat
enum OuputAspectRatio {
  /// Aspect ratio 4:3
  four_three,

  /// Aspect ratio 16:9
  sixteen_nine,

  /// Aspect ratio 1:1
  one_one,

  /// All other aspect ratios
  unknown,
}
