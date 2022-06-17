import 'package:flutter/material.dart';

class TitleCategory extends StatelessWidget {
  final String titleCategory;
  final Icon icon;
  final void Function()? onPressed;
  const TitleCategory(
      {Key? key,
      required this.titleCategory,
      required this.icon,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          titleCategory,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        IconButton(onPressed: onPressed, icon: icon),
      ],
    );
  }
}
