import 'package:flutter/material.dart';

class Underweight extends StatelessWidget {
  const Underweight({super.key});
  Future<void> _preloadImage(BuildContext context,String imagePath)async{
    /// the precacheImage is a flutter method
    await precacheImage(AssetImage(imagePath),context);
  }

  @override
  Widget build(BuildContext context) {
    const imagePath = 'assets/image/Underweight.jpg';
    return Scaffold(
      body: FutureBuilder<void>(
        future: _preloadImage(context, imagePath),
        builder: (context, snapshot) {
          /// the ConnectionState is an enum int the async class
          if(snapshot.connectionState == ConnectionState.done ){
            return const Column(
              children: [
                SizedBox(height: 100,),
                Image(image: AssetImage('assets/image/Underweight.jpg')),
                SizedBox(height: 11,),
                Text('Underweight',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.yellow))
              ],
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
