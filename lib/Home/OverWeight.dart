/*
import 'package:flutter/material.dart';

class Overweight extends StatelessWidget {
  const Overweight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI'),
      ),
      body: Column(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage('assets/image/overweight.jpg'), fit: BoxFit.contain)),
          //   child: Text(":>"),
          // )
          Image(image: AssetImage('assets/image/overweight.jpg')),
          SizedBox(
            height: 11,
          ),
          Text('Over weight',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.red),)
        ],
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

