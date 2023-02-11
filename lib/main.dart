// Derived from: https://github.com/matthew-carroll/flutter_processing/blob/main/example/lib/generative_art/colored_circles.dart

import 'dart:typed_data';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_processing/flutter_processing.dart';
import 'dart:developer';

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
  List fixedPaint = [];
  List paint = [];
  List tempPaint1 = [];
  List tempPaint2 = [];
  ByteData? pixelBeforePaint;
  ByteData? pixelAfterPaint;
  bool coin = true;
  bool runnyColors = false;
  Color paintColor = Color.fromARGB(255, 47, 6, 230);
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
        Color.fromARGB(255, 255, 255, 255),
        growable: true);

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
    paint = fixedPaint;
    await updatePixels(); // Draws pixels array buffer to screen
  }

  @override
  Future<void> draw() async {
    // addPaint();
    // update();
    // render ();
/**
 * WOrkflow
 * 
 * setup - create blank canvas
 * On each paint :
 * 1. before paint call loadPixels to load the current screen into the pixel array
 * 2. copy the pixel array into the pixelBeforePaint array
 * 3. call the paint commands
 * 4. call loadPixels to store the updated screen with the new paint swatch
 * 5. copy the pixel array into the pixelAfterPaint array
 * 6. Merge the 2 arrays by averaging each pixel ( use set to update the pixel array)
 * 7. call updatePixels to output the updated pixel array
 * 
 */

    if (paint.isNotEmpty) {
      //TEMP CODE----------------------
      await loadPixels(); // COPY the screen image into the pixels array //1.
      pixelBeforePaint = pixels; //2.
      drawLinePoints(100, 100, 230, 250, 100); //3.
      await loadPixels(); // COPY the screen image into the pixels array//4.
      pixelAfterPaint = pixels; //5.
      updateCanvas();
      await updatePixels(); // Draws pixels array buffer to screen

      paintColor = Color.fromARGB(151, 56, 238, 1);
      await loadPixels(); // COPY the screen image into the pixels array //1.
      pixelBeforePaint = pixels; //2.
      drawLinePoints(110, 110, 240, 260, 100); //3.
      await loadPixels(); // COPY the screen image into the pixels array//4.
      pixelAfterPaint = pixels; //5.
      updateCanvas();
      await updatePixels(); // Draws pixels array buffer to screen

      paintColor = Color.fromARGB(237, 255, 137, 3);
      await loadPixels(); // COPY the screen image into the pixels array //1.
      pixelBeforePaint = pixels; //2.
      drawLinePoints(130, 110, 250, 280, 100); //3.
      await loadPixels(); // COPY the screen image into the pixels array//4.
      pixelAfterPaint = pixels; //5.
      updateCanvas();
      await updatePixels(); // Draws pixels array buffer to screen
      //END TEMP CODE _-----0-0--------------------------------------------------

      noLoop();
    }
  }

/**
 * When calledd this method blend 2 pixels arrays. the bottom capturing the current canvans and the top capturing recent paint commands
 * this will cause the paint to blend. we need to investigate to see if the blend goes to the right and down
 */
  void updateCanvas() {
    Color bottomColor;
    Color topColor;
    for (int row = 0; row < height; ++row) {
      for (int col = 0; col < width; ++col) {
        bottomColor = getPixelColor(col, row, width, pixelBeforePaint);
        topColor = getPixelColor(col, row, width, pixelAfterPaint);

        int newRed = round((bottomColor.red + topColor.red) / 2);
        int newGreen = round((bottomColor.green + topColor.green) / 2);
        int newBlue = round((bottomColor.blue + topColor.blue) / 2);
        set(
            x: col,
            y: row,
            color: Color.fromARGB(255, newRed, newGreen, newBlue));
      }
    }
  }

/***
 * returns the color of a entry in a pixel array
 */
  Color getPixelColor(int x, int y, int w, ByteData? bd) {
    final pixelDataOffset = _getBitmapPixelOffset(
      imageWidth: w,
      x: x,
      y: y,
    );
    final imageData = bd!;
    final rgbaColor = imageData.getUint32(pixelDataOffset);
    final argbColor =
        ((rgbaColor & 0x000000FF) << 24) | ((rgbaColor & 0xFFFFFF00) >> 8);
    return Color(argbColor);
  }

  void addPaint() {
    // drawLinePoints(prevMouseX, prevMouseY, mouseX, mouseY, numPoints);
  }

  void drawLinePoints(x1, y1, x2, y2, points) {
    for (int i = 0; i < points; i++) {
      double t = map(i, 0, points, 0.0, 1.0).toDouble();
      int x = round(lerp(x1, x2, t));
      int y = round(lerp(y1, y2, t));
      log('OK we are on Loop #$i  drawing a line from ($x1 , $y1) to ( $x2, $y2) -- t: $t x: $x  & y: $y');
      renderPoints(x, y);
    }
  }

  // replace array points when drawing
  void renderPoints(x, y) {
    int arrayPos = (x + y * width);
    Color baseColor = paint[arrayPos];
    Color paintedColor = paintColor;

    int newRed = round((baseColor.red + paintedColor.red) / 2);
    int newGreen = round((baseColor.green + paintedColor.green) / 2);
    int newBlue = round((baseColor.blue + paintedColor.blue) / 2);
    Iterable<Color> iterable = [Color.fromARGB(255, newRed, newGreen, newBlue)];
// paint.replaceRange(start, end, replacements)

    // paint.replaceRange(arrayPos, arrayPos, iterable);
    // set(x: x, y: y, color: Color.fromARGB(255, newRed, newGreen, newBlue));

    // for (int row = 0; row < 120; ++row) {
    //   for (int col = 0; col < 120; ++col) {
    //     int xCoord = x + (row - 60);
    //     int yCoord = y + (row - 60);
    //     set(
    //         x: xCoord,
    //         y: yCoord,
    //         color: Color.fromARGB(255, newRed, newGreen, newBlue));
    //   }
    // }
    fill(
      color: Color.fromARGB(255, newRed, newGreen, newBlue),
    );
    stroke(
      color: Color.fromARGB(255, newRed, newGreen, newBlue),
    );

    circle(
      center: Offset(x.toDouble(), y.toDouble()),
      diameter: 20,
    );

    fill(
      color: paintedColor,
    );
    stroke(
      color: paintedColor,
    );

    circle(
      center: Offset((x + 70).toDouble(), (y + 70).toDouble()),
      diameter: 20,
    );
    log('x: $x  & y: $y');
    // await loadPixels(); // COPY the screen image into the pixels array
    // await updatePixels(); // Draws pixels array buffer to screen
  }

  // void renderPoints(x, y) {
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
// }

  int _getBitmapPixelOffset({
    required int imageWidth,
    required int x,
    required int y,
  }) {
    return ((y * imageWidth) + x) * 4;
  }
}
