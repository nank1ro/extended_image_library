import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/widgets.dart';

export '_extended_network_image_utils_io.dart'
    if (dart.library.js_interop) '_extended_network_image_utils_web.dart';
export '_platform_io.dart' if (dart.library.js_interop) '_platform_web.dart';

const String cacheImageFolderName = 'cacheimage';

///clear all of image in memory
void clearMemoryImageCache([String? name]) {
  if (name != null) {
    if (imageCaches.containsKey(name)) {
      imageCaches[name]!.clear();
      imageCaches[name]!.clearLiveImages();
      imageCaches.remove(name);
    }
  } else {
    PaintingBinding.instance.imageCache.clear();

    PaintingBinding.instance.imageCache.clearLiveImages();
  }
}

/// get ImageCache
ImageCache? getMemoryImageCache([String? name]) {
  if (name != null) {
    if (imageCaches.containsKey(name)) {
      return imageCaches[name];
    } else {
      return null;
    }
  } else {
    return PaintingBinding.instance.imageCache;
  }
}

/// get network image data from cached
Future<Uint8List?> getNetworkImageData(
  String url, {
  bool useCache = true,
  StreamController<ImageChunkEvent>? chunkEvents,
}) async {
  return ExtendedNetworkImageProvider(
    url,
    cache: useCache,
  ).getNetworkImageData(chunkEvents: chunkEvents);
}

/// get md5 from key
String keyToMd5(String key) => md5.convert(utf8.encode(key)).toString();
