// Derived from: https://github.com/matthew-carroll/flutter_processing/blob/main/example/lib/generative_art/colored_circles.dart

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_processing/flutter_processing.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: Processing(
//         sketch: Sketch.simple(
//           setup: (s) async {
//             s.size(width: 500, height: 500);
//             // s.background(color: Color.fromARGB(255, 58, 158, 88));
//             s.circle(center: Offset(160, 100), diameter: 100);
//             // late PImage _canvasImage =
//             //     PImage.empty(500, 500, ImageFileFormat.png);
//             // await s.image(image: _canvasImage);
//           },
//           draw: (s) async {
//             // late PImage _canvasImage =
//             //     PImage.empty(500, 500, ImageFileFormat.png);
//             // await s.image(image: _canvasImage);

//             await s.loadPixels();
//             // s.circle(center: Offset(400, 150), diameter: 100);
//             for (int col = 0; col < 180; ++col) {
//               for (int row = 0; row < 50; ++row) {
//                 s.set(x: col, y: row, color: Color(0xFF000000));
//                 //  s.set(x: col, y: row, color: Color.fromARGB(237, 255, 218, 8));?
//               }
//             }
//             await s.updatePixels();
//             // for (int col = 0; col < 190; ++col) {
//             //   for (int row = 0; row < 50; ++row) {
//             //     s.set(x: col, y: row, color: Color.fromARGB(255, 192, 5, 120));
//             //   }
//             // }
//             // s.updatePixels();
//             // TODO: do your typical Sketch drawing
//             //       stuff here. Call methods on
//             //       the provided sketch object.
//           },
//         ),
//       ),
//     ),
//   );
// }
void main() {
  runApp(
    MaterialApp(
      home: Processing(
        sketch: ColoredCirclesSketch(
          width: 400,
          height: 400,
        ),
      ),
    ),
  );
}

// class MySketch extends Sketch {
//   @override
//   Future<void> setup() async {
//     // TODO: do setup stuff here
//   }

//   @override
//   Future<void> draw() async {
//     await loadPixels();

//     for (int col = 0; col < 400; ++col) {
//       for (int row = 0; row < 400; ++row) {
//         set(x: col, y: row, color: const Color(0xFF00FF00));
//       }
//     }
//     // await setRegion(image: subImage);

//     await updatePixels();
//   }
// }

class ColoredCirclesSketch extends Sketch {
  ColoredCirclesSketch({
    required this.width,
    required this.height,
    this.maxCircleRadius = 30.0,
    this.circleMargin = 5.0,
    this.innerCircleProbability = 0.50,
  });

  @override
  final int width;
  @override
  final int height;
  final double maxCircleRadius;
  final double circleMargin;
  final double innerCircleProbability;

  @override
  void setup() {
    size(width: width, height: height);
  }

  @override
  Future<void> draw() async {
    // background(color: Color.fromARGB(255, 3, 187, 147));
    // noStroke();
    // random color fill
    fill(
      color: HSVColor.fromAHSV(1.0, random(360), 0.7, 0.8).toColor(),
    );

    circle(
      center: Offset(150, 250),
      diameter: 80,
    );
    await loadPixels(); // copy the screen - creating the pixel buffer
    circle(
      center: Offset(150, 100),
      diameter: 50,
    );

    for (int col = 0; col < 100; ++col) {
      for (int row = 0; row < 100; ++row) {
        set(x: col, y: row, color: const Color(0xFF00FF00));
      }
    }
    // await setRegion(image: subImage);

    await updatePixels(); // draw the pixel buffer to screen

    noLoop();
  }
}
