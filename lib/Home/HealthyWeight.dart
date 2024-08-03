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
