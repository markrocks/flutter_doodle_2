// Derived from: https://github.com/matthew-carroll/flutter_processing/blob/main/example/lib/generative_art/colored_circles.dart

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_processing/flutter_processing.dart';

void main() {
  runApp(
    MaterialApp(
      home: Processing(
        sketch: PaintBoardSketch(
          width: 630,
          height: 450,
        ),
      ),
    ),
  );
}

class PaintBoardSketch extends Sketch {
  PaintBoardSketch({
    required this.width,
    required this.height,
  });

  @override
  final int width;
  @override
  final int height;
  Color paintColor = Color.fromARGB(255, 3, 187, 147);
  List fixedPaint = [];
  List paint = [];
  List tempPaint1 = [];
  List tempPaint2 = [];
  bool coin = true;
  bool runnyColors = false;
  Color paintColor = Color.fromARGB(255, 182, 91, 6);
  // int x = 0;
  // int y = 0;
  // double z = 1.5;
  // int xFactor = 1;
  // int yFactor = 1;
  // int xRange = 400;
  // int yRange = 450;

  @override
  Future<void> setup() async {
    size(width: width, height: height);
    fixedPaint = List<Color>.filled(
        // Add  the val of width to the size to avoid multiply by zero offset
        ((height * width) + width),
        Color.fromARGB(255, 255, 255, 255));

    await loadPixels(); // COPY the screen image into the pixels array
    for (int row = 0; row < height; ++row) {
      for (int col = 0; col < width; ++col) {
        // set(x: col, y: row,color: const Color(0xFF0000FF)); // CHANGES the PIXEL array
        set(
            x: col,
            y: row,
            color: fixedPaint[
                col + (row * width)]); // set white box in pixel array
      }
    }
    await updatePixels(); // Draws pixels array buffer to screen
  }

@override
  Future<void> draw() async {
    // addPaint();
    // update();
    // render ();
  }

  void addPaint() {
    // drawLinePoints(prevMouseX, prevMouseY, mouseX, mouseY, numPoints);
  }

  void drawLinePoints(x1, y1, x2, y2, points) {

  }

  void renderPoints(x, y) {
  //Get pixel array current Color val
  // Color currentPixelColor = Color arry val
  // get the red value and sum it with the selected paint color red valu and divide by 2 ( to average the red value)
  // then do the same for the green and blue

  // now replace the array color val with that color

  // int arrayPos = (x + y * width) * 4; // TODO FIX THIS!!!
  // num newR = (paint[arrayPos + 0] + colorPicked.red) / 2;
  // num newG = (paint[arrayPos + 1] + colorPicked.green) / 2;
  // num newB = (paint[arrayPos + 2] + colorPicked.blue) / 2;
  // num newN = paint[arrayPos + 3] + paintDrop;
  // paint.replaceRange(arrayPos, 4, [
  //   newR,
  //   newG,
  //   newB,
  //   newN
  // ]); // replace the current pixel color with the newly calculated color
}



//   @override
//   Future<void> draw() async {
//     // NOTE you cannot call the 'set" command before a pixel array is  created.
//     // So if you call set before you call loadPixels it will throw an error

//     // renderPoints(randonVal(xx), randonVal(yy));
//     // 1. FILL WHITE -- create a white square
//     // await loadPixels(); // COPY the screen image into the pixels array
//     // for (int col = 0; col < 100; ++col) {
//     //   for (int row = 0; row < 100; ++row) {
//     //     // set(x: col, y: row,color: const Color(0xFF0000FF)); // CHANGES the PIXEL array
//     //     set(
//     //         x: col,
//     //         y: row,
//     //         color: fixedPaint[col * row]); // set white box in pixel array
//     //   }
//     // }
//     // await updatePixels(); // Draws pixels array buffer to screen

//     // await loadPixels(); // COPY the screen image into the pixels array

//     //2. Draw a Circle
//     //==============
//     fill(
//         color: HSVColor.fromAHSV(1.0, random(360), 0.7, 0.8)
//             .toColor()); // JUST SETS THE FILL COLOR
//     circle(center: Offset(250, 250), diameter: 180);

//     // await updatePixels(); // Draws pixels array buffer to screen
// // EXPECT to have a white square and a color changing circle

//     // NOTE: For some reason the pixel buffer does not work on Chrome -- just Android
//     await loadPixels(); // copy the screen - creating the pixel buffer
//     circle(center: Offset(150, 100), diameter: 50);
//     circle(center: Offset(250, 100), diameter: 50);
//     // await loadPixels();
//     for (int col = 0; col < 100; ++col) {
//       for (int row = 0; row < 100; ++row) {
//         set(
//             x: col,
//             y: row,
//             color: HSVColor.fromAHSV(1.0, random(360), 0.7, 0.8).toColor());
//         set(x: col, y: row, color: fixedPaint[col * row]);
//       }
//     }
//     // await setRegion(image: subImage);
//     await loadPixels();
//     await updatePixels(); // draw the pixel buffer to screenss

//     // noLoop();
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
      center: Offset(450, 200),
      diameter: 50,
    );

    for (int col = 0; col < 100; ++col) {
      for (int row = 0; row < 100; ++row) {
        // set(x: col, y: row, color: Color.fromARGB(255, 24, 139, 24));
        set(
            x: col,
            y: row,
            color: HSVColor.fromAHSV(1.0, random(360), 0.7, 0.8).toColor());
      }
    }
    // await setRegion(image: subImage);?

    await updatePixels(); // draw the pixel buffer to screen

    noLoop();
  }
}
