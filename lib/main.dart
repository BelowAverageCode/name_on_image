import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<void> _createImageWithText() async {
    final image = img.Image(400, 200);
    img.fill(image, img.getColor(255, 255, 255));

    // Draw the text onto the image
    img.drawString(
      image,
      img.arial_48,
      100, // X position
      75,  // Y position
      'Lakshay',
      color: img.getColor(0, 0, 0), // Black color
    );

    // Get the document directory
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/chatgpt_image.png';

    // Convert the image to a PNG and save it
    final pngBytes = Uint8List.fromList(img.encodePng(image));
    final file = File(path);
    await file.writeAsBytes(pngBytes);

    print('Image saved to $path');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _createImageWithText,
          child: Text('Generate Image'),
        ),
      ),
    );
  }
}
