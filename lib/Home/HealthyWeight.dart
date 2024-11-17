/*
import 'package:flutter/material.dart';

class Healthyweight extends StatelessWidget {
  const Healthyweight({super.key});
  Future<void>_preloadImage(BuildContext context,String imagePath)async{
    await precacheImage(AssetImage(imagePath), context);
}

  @override
  Widget build(BuildContext context) {
    const imagePath = 'assets/image/Healthy.jpg';
    return Scaffold(
      body: FutureBuilder<void>(
        future: _preloadImage(context, imagePath),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return const Column(
              children: [
                SizedBox(height: 100,),
                Flexible(child: Image(image: AssetImage('assets/image/Healthy.jpg'),)),
                SizedBox(height: 11,),
                Text('Healthy',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.green))
              ],
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
*/



import 'package:flutter/material.dart';

class Healthyweight extends StatelessWidget {
  const Healthyweight({super.key});

  Future<void> _preloadImage(BuildContext context, String imagePath) async {
    await precacheImage(AssetImage(imagePath), context);
  }

  @override
  Widget build(BuildContext context) {
    const imagePath = 'assets/image/Healthy.jpg';
    return Scaffold(
      body: FutureBuilder<void>(
        future: _preloadImage(context, imagePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  SizedBox(
                    height: 300, // Specify a fixed height or use another widget.
                    child: const Image(image: AssetImage(imagePath)),
                  ),
                  const SizedBox(height: 11),
                  const Text(
                    'Healthy',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.green),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
