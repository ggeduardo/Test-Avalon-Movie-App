import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:test_avalon_movie_app/static/api.dart';

class CachedImage extends StatelessWidget {
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final String path;
  const CachedImage(
      {Key? key, required this.path, this.boxFit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        placeholder: (context, _) {
          return JumpingDotsProgressIndicator(
              fontSize: 40.0, dotSpacing: 3, color: Colors.grey[500]!);
        },
        errorWidget: (context, error, img) => const Icon(
          Icons.image,
          size: 50,
          color: Colors.blue,
        ),
        imageUrl: Api.backendUpPhoto + path,
        fit: boxFit,
        height: height,
        width: width,
      ),
    );
  }
}
