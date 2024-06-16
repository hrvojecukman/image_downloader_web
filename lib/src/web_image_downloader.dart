import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_downloader_web/src/image_type.dart';
import 'package:universal_html/html.dart' as html;

class WebImageDownloader {
  /// Download image from URL to user's device. It works only for Flutter web.
  static Future<void> downloadImageFromWeb(
    String url, {
    Map<String, String>? headers,
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
        name: name,
        imageType: imageType,
      );
    } else {
      throw Exception(res.statusCode);
    }
  }

  /// Download image from uInt8List to user device
  static Future<void> downloadImageFromUInt8List({
    required Uint8List uInt8List,
    String? name,
    ImageType imageType = ImageType.png,
  }) async {
    final blob = html.Blob([uInt8List], imageType.format);

    final blobUrl = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: blobUrl)
      ..download = name ?? blobUrl
      ..click();

    html.Url.revokeObjectUrl(blobUrl);
  }
}
