import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowDialog {
  static Future showCalories(
      Map<String, dynamic> item, BuildContext context) async {
    int fat = item['FAT']['quantity'].toInt();
    int sFat = item['FASAT']['quantity'].toInt();
    int cholesterol = item['CHOLE']['quantity'].toInt();
    int nA = item['NA']['quantuity'].toInt();
    int carbohydrate = item['CHOCDF.net']['quantity'].toInt();
    int sugar = item['SUGAR']['quantity'].toInt();
    int protein = item['PROCNT']['quantity'].toInt();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.redAccent,
            title: const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Text(
                  'Nutritional Fact',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            content: Container(
              height: 300,
              color: Colors.white,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text('Total Fat'),
                         Text(fat.toString())
                       ],
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Saturated Fat'),
                        Text(sFat.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cholesterol'),
                        Text(cholesterol.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sodium'),
                        Text(nA.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Carbohydrates'),
                        Text(carbohydrate.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Sugar'),
                        Text(sugar.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Protein'),
                        Text(protein.toString())
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
