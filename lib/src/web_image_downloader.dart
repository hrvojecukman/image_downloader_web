import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class WebImageDownloader {
  Future<void> downloadImageFromWeb(
    String url, {
    Map<String, String>? headers,
    double imageQuality = 0.95,
  }) async {
    final http.Response res = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (res.statusCode == 200) {
      await _downloadImageFromUInt8List(
        uInt8List: res.bodyBytes,
        imageQuality: imageQuality,
      );
    } else {
      throw Exception(res.statusCode);
    }
  }

  Future<void> _downloadImageFromUInt8List({
    required Uint8List uInt8List,
    required double imageQuality,
  }) async {
    final image = await decodeImageFromList(uInt8List);

    final html.CanvasElement canvas = html.CanvasElement(
      height: image.height,
      width: image.width,
    );

    final ctx = canvas.context2D;

    final List<String> binaryString = [];

    for (final imageCharCode in uInt8List) {
      final charCodeString = String.fromCharCode(imageCharCode);
      binaryString.add(charCodeString);
    }
    final data = binaryString.join();

    final base64 = html.window.btoa(data);

    final img = html.ImageElement();

    img.src = "data:image/jpeg;base64,$base64";

    final html.ElementStream<html.Event> loadStream = img.onLoad;

    loadStream.listen((event) {
      ctx.drawImage(img, 0, 0);
      final dataUrl = canvas.toDataUrl("image/jpeg", imageQuality);
      final html.AnchorElement anchorElement =
          html.AnchorElement(href: dataUrl);
      anchorElement.download = dataUrl;
      anchorElement.click();
    });
  }
}
