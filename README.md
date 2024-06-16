# Image downloader for web

Download images from URL on Flutter Web

![Usage example](https://hrvojecukman.github.io/image_downloader_web/demo.gif)

## Download image on webb

```dart

const _url = "https://picsum.photos/200";

Future<void> _downloadImage() async {
  await WebImageDownloader.downloadImageFromWeb(_url);
}

```

&nbsp;

## Download image on web from UInt8List

```dart

final uint8List = Uint8List();

Future<void> _downloadImage() async {
  await WebImageDownloader.downloadImageFromUInt8List(uInt8List: uint8List);
}

```

&nbsp;

### Download image with custom headers

```dart

const _url = "https://picsum.photos/200";

Future<void> _downloadImage() async {
  final Map<String, String> headers = {
    'authorization': token,
  };
  await WebImageDownloader.downloadImageFromWeb(_url, headers: headers);
}
```
