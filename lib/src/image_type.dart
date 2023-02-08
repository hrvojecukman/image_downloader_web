enum ImageType {
  /// Animated Portable Network Graphics (APNG)
  apng('image/apng'),

  /// AV1 Image File Format (AVIF)
  avif('image/avif'),

  /// Graphics Interchange Format (GIF)
  gif('image/gif'),

  /// Joint Photographic Expert Group image (JPEG)
  jpeg('image/jpeg'),
  
  /// Joint Photographic Expert Group image (JPEG)
  jpg('image/jpg'),

  /// Portable Network Graphics (PNG)
  png('image/png'),

  /// Scalable Vector Graphics (SVG)
  svg('image/svg+xml'),

  /// Web Picture format (WEBP)
  webp('image/webp');

  const ImageType(this.format);

  final String format;
}
