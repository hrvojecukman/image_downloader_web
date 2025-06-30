import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader_web/src/image_type.dart';
import 'package:web/web.dart' as web;

class WebImageDownloader {
  /// Download image from URL to user's device. It works only for Flutter web.
  static Future<void> downloadImageFromWeb(
    String url, {
    Map<String, String>? headers,
    double imageQuality = 0.95,
    String? name,
    ImageType imageType = ImageType.png,
  }) async {
    final http.Response res = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (res.statusCode == 200) {
      await downloadImageFromUInt8List(
        uInt8List: res.bodyBytes,
        imageQuality: imageQuality,
        name: name,
        imageType: imageType
      );
    } else {
      throw Exception(res.statusCode);
    }
  }

  /// Download image from uInt8List to user device
  static Future<void> downloadImageFromUInt8List({
    required Uint8List uInt8List,
    double imageQuality = 0.95,
    String? name,
    ImageType imageType = ImageType.png,
  }) async {
    final image = await decodeImageFromList(uInt8List);

    final web.HTMLCanvasElement canvas = web.HTMLCanvasElement();
    canvas.width = image.width;
    canvas.height = image.height;

    final ctx = canvas.context2D;

    final List<String> binaryString = [];

    for (final imageCharCode in uInt8List) {
      final charCodeString = String.fromCharCode(imageCharCode);
      binaryString.add(charCodeString);
    }
    final data = binaryString.join();

    final base64 = web.window.btoa(data);

    final img = web.HTMLImageElement();

    img.src = "data:${imageType.format};base64,$base64";

    final web.ElementStream<web.Event> loadStream = img.onLoad;

    loadStream.listen((event) {
      ctx.drawImage(img, 0, 0);
      final dataUrl = canvas.toDataUrl(imageType.format, imageQuality);
      final web.HTMLAnchorElement anchorElement = web.HTMLAnchorElement();
      anchorElement.href = dataUrl;
      anchorElement.download = name ?? dataUrl;
      anchorElement.click();
    });
  }
}
