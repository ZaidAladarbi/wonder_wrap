// ignore_for_file: file_names

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'AppWidgetsLib.dart';

AppLib appLib = AppLib();

class ImageCacheManager {
  final Map<String, Uint8List> _imageCache = {};

  Future<Uint8List?> getImage(String key) async {
    if (_imageCache.containsKey(key)) {
      return _imageCache[key];
    } else {
      final decodedImage = await appLib.decodePhotoAsync(key);
      _imageCache[key] = decodedImage;
      return decodedImage;
    }
  }
}
