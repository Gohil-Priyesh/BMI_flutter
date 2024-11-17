/*

import 'package:flutter/material.dart';

class Overweight extends StatelessWidget {
  const Overweight({super.key});

  Future<void> _preloadImage(BuildContext context, String imagePath) async {
    await precacheImage(AssetImage(imagePath), context);
  }

  @override
  Widget build(BuildContext context) {
    const imagePath = 'assets/image/overweight.jpg';

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI'),
      ),
      body: FutureBuilder<void>(
        future: _preloadImage(context, imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Column(
              children: [
                Image(image: AssetImage(imagePath)),
                SizedBox(height: 11),
                Text(
                  'Over weight',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.red,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

*/

import 'package:flutter/material.dart';

class Overweight extends StatelessWidget {
  const Overweight({super.key});

  Future<void> _preloadImage(BuildContext context, String imagePath) async {
    await precacheImage(AssetImage(imagePath), context);
  }

  @override
  Widget build(BuildContext context) {
    const imagePath = 'assets/image/overweight.jpg';

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI'),
      ),
      body: FutureBuilder<void>(
        future: _preloadImage(context, imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 300, // Specify a fixed height for the image.
                    child: const Image(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 11),
                  const Text(
                    'Over weight',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}