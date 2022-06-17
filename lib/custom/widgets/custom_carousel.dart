import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<Widget> items;
  final double height;
  final bool autoPlay;
  final bool enlargeCenterPage;
  final bool enableInfiniteScroll;
  final bool reverse;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final Axis scrollDirection;
  final double viewportFraction;
  final double aspectRatio;
  final int initialPage;
  final int indexDot;
  final CarouselController controller;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final bool enableDots;

  const CustomCarouselSlider({
    Key? key,
    required this.items,
    required this.height,
    required this.controller,
    this.autoPlay = true,
    this.enlargeCenterPage = true,
    this.enableDots = false,
    this.enableInfiniteScroll = true,
    this.reverse = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.scrollDirection = Axis.horizontal,
    this.viewportFraction = 0.8,
    this.aspectRatio = 4.0,
    this.initialPage = 0,
    this.indexDot = 0,
    this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: items,
          carouselController: controller,
          options: CarouselOptions(
              autoPlay: autoPlay,
              enlargeCenterPage: enlargeCenterPage,
              viewportFraction: viewportFraction,
              aspectRatio: aspectRatio,
              initialPage: initialPage,
              height: height,
              enableInfiniteScroll: enableInfiniteScroll,
              reverse: reverse,
              autoPlayInterval: autoPlayInterval,
              autoPlayAnimationDuration: autoPlayAnimationDuration,
              autoPlayCurve: autoPlayCurve,
              scrollDirection: scrollDirection,
              onPageChanged: onPageChanged),
        ),
        if (enableDots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  controller.animateToPage(entry.key);
                },
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                          .withOpacity(indexDot == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
