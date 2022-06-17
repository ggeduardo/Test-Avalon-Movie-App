import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String textLeft;
  final String textRight;
  final double width;
  final Widget? icon;
  const CustomRow(
      {Key? key,
      required this.textLeft,
      required this.textRight,
      this.icon,
      this.width = 0.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          textLeft,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 17,
              ),
        )),
        SizedBox(
          width: _size.width * width,
          child: Text(
            textRight,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        if (icon != null) icon!,
      ],
    );
  }
}
