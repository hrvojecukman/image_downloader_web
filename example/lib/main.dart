import 'package:flutter/material.dart';
import 'package:image_downloader_web/image_downloader_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web image downloader example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageDownloaderExample(),
    );
  }
}

class ImageDownloaderExample extends StatefulWidget {
  const ImageDownloaderExample({Key? key}) : super(key: key);

  @override
  _ImageDownloaderExampleState createState() => _ImageDownloaderExampleState();
}

class _ImageDownloaderExampleState extends State<ImageDownloaderExample> {
  final WebImageDownloader _webImageDownloader = WebImageDownloader();
  bool downloading = false;

  Future<void> _downloadImage() async {
    setState(() {
      downloading = true;
    });
    const _url = "https://picsum.photos/200";
    await _webImageDownloader.downloadImageFromWeb(_url);
    setState(() {
      downloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web image downloader example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (downloading)
              const CircularProgressIndicator()
            else
              MaterialButton(
                onPressed: _downloadImage,
                child: const Text(
                  "Download",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
              )
          ],
        ),
      ),
    );
  }
}
