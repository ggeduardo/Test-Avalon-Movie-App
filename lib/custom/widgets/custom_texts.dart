import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  const CustomText({Key? key, required this.text, this.fontSize = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: fontSize,
          ),
    );
  }
}

class CustomTextBody extends StatelessWidget {
  final String text;
  final double? fontSize;
  const CustomTextBody({Key? key, required this.text, this.fontSize = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
          ),
    );
  }
}
