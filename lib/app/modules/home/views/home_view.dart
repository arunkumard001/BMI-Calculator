import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final _formkey = GlobalKey<FormState>();
  final HomeController firstcontroller = Get.put(HomeController());
  final heightcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  final agecontroller = TextEditingController();

  bool gender = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "BMI calculator",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white38,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Newgender(
                  gender: gender,
                  gendertitle: "Man",
                  colors: Colors.blue,
                ),
                Newgender(
                  gender: !gender,
                  gendertitle: "Woman",
                  colors: Colors.pink,
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty || value.length > 3) {
                  //       return "please enter the age";
                  //     } else {}
                  //   },
                  //   keyboardType: TextInputType.number,
                  //   controller: agecontroller,
                  //   decoration: InputDecoration(
                  //       hintText: "enter the age",
                  //       border: OutlineInputBorder()),
                  // ),
                  // SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 3) {
                        return "please enter the weight";
                      } else {}
                    },
                    keyboardType: TextInputType.number,
                    controller: weightcontroller,
                    decoration: InputDecoration(
                        hintText: "enter the weight in kg",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 3) {
                        return "please enter the height";
                      } else {}
                    },
                    keyboardType: TextInputType.number,
                    controller: heightcontroller,
                    decoration: InputDecoration(
                        hintText: "enter the height in m",
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
                onPressed: () {
                  calculatebmi();
                },
                icon: Icon(Icons.check_box),
                label: Text("calculate")),
          ],
        ),
      ),
    );
  }

  calculatebmi() {
    _formkey.currentState!.validate();
    double weight = double.parse(weightcontroller.text);
    double height = double.parse(heightcontroller.text);
    // int age = int.parse(agecontroller.text);

    double bmi = (weight / (height * height));
    print(bmi.toString());
    if (bmi > 40.0) {
      Get.snackbar("Extreme obese", bmi.toString());
    }
    if (bmi < 30) {
      Get.snackbar("obeses", bmi.toString());
    }
    if (bmi < 25) {
      Get.snackbar("overweight", bmi.toString());
    }
    if (bmi < 18.5) {
      Get.snackbar("Normal", bmi.toString());
    }
    if (bmi < 15) {
      Get.snackbar("underweight", bmi.toString());
    }
  }
}

class Newgender extends StatefulWidget {
  Newgender({
    Key? key,
    required this.gender,
    required this.gendertitle,
    required this.colors,
  }) : super(key: key);

  bool gender;
  final String gendertitle;
  Color colors;
  @override
  State<Newgender> createState() => _NewgenderState();
}

class _NewgenderState extends State<Newgender> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.gender = !widget.gender;
        });
      },
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.gender ? widget.colors : Colors.red,
        ),
        child: Center(
            child: Text(
          widget.gendertitle,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
