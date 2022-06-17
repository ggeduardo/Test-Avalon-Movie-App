import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final bool? needIcon;
  const CustomAppBar({Key? key, this.needIcon = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (needIcon!)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white)),
          const Text(
            'MOAPLON',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          if (needIcon!) Expanded(child: Container()),
        ],
      ),
    );
  }
}
