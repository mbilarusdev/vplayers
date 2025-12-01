class AssetPaths {
  const AssetPaths._();
  static String videoPath({required int videoIndex, String videoFormat = "mp4"}) =>
      "assets/video/video${videoIndex+1}.$videoFormat";
}
