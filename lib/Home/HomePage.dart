import 'package:bmi_flutter/Home/HealthyWeight.dart';
import 'package:bmi_flutter/Home/OverWeight.dart';
import 'package:bmi_flutter/Home/UnderWeight.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var ft = TextEditingController();
  var inch = TextEditingController();
  var weight = TextEditingController();
  var result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4facfe),
              Color(0xff00f2fe)
            ],
            begin: FractionalOffset(0.1,0.5),
            end: FractionalOffset(1.0,0.5)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('BMI Calculator',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 35),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Enter your  height in feet'),
                  prefixIcon: const Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:const BorderSide(
                      color: Colors.lightBlue
                    )
                  ),
                ),
                controller: ft,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Enter your height in inch'),
                  prefixIcon: const Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.lightBlue
                    )
                  )
                ),
                controller:inch ,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Enter your weight in kg'),
                  prefixIcon: const Icon(Icons.monitor_weight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.lightBlue
                    )
                  )
                ),
                controller: weight,
              ),
            ),
            ElevatedButton(onPressed: (){
              var hift = int.parse(ft.text.toString());
              var hiin = int.parse(inch.text.toString());
              var wi = int.parse(weight.text.toString());
              if(wi!=""&&hift!=""&&hiin!=""){
              var  tin = (hift*12)+hiin;
                var cm = tin*2.54;
                var tm = cm/100;
                var bmi = wi/(tm*tm);
                result="you BMI  is ${bmi.toStringAsFixed(2)}";
                if(bmi>25){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Overweight(),));
                }else if (bmi<18){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Underweight(),));
                }else{
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Healthyweight(),));
                }
                setState(() {

                });
              }else{
                setState(() {
                  result = "please fill the above fields";
                });
              }

            }, child: const Text('Calculate')),
            Text(result,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
          ],
        ),
      ),
    );
  }
}
