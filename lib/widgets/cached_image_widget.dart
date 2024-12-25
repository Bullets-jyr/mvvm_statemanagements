import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';

class CachedImageWidget extends StatelessWidget {
  final String imgUrl;
  final double? imgHeight;
  final double? imgWidth;
  final BoxFit? boxFit;

  const CachedImageWidget({
    super.key,
    required this.imgUrl,
    this.imgHeight,
    this.imgWidth,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return CachedNetworkImage(
      height: imgHeight ?? size.width * 0.3,
      width: imgWidth ?? size.width * 0.2,
      imageUrl: imgUrl,
      // ?? 'https://i.ibb.co/FwTPCCc/Ultra-Linx.jpg',
      fit: boxFit ?? BoxFit.cover,
      errorWidget: (
        BuildContext context,
        String url,
        Object error,
      ) =>
          const Icon(
        MyAppIcons.error,
        color: Colors.red,
      ),
    );
  }
}
