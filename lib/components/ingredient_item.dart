import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class IngredientItem extends StatelessWidget {
  final String quantity, measure, food, imageUrl;
    const IngredientItem(
      {super.key,
      required this.quantity,
      required this.measure,
      required this.food,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var myBox = Hive.box('shopping');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * .033, vertical: h * .01),
      padding: EdgeInsets.only(
          top: h * .008, bottom: h * .008, left: h * .008, right: w * .08),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 3,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            )
          ]),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: w * .2,
                height: h * .1,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '$food\n$quantity $measure',
              style: TextStyle(
                  fontSize: w * .04,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            SizedBox(
              width: w * .033,
            ),
            ValueListenableBuilder(
              valueListenable: myBox.listenable(),
              builder: (context, box, _) {
                bool exist = box.containsKey(food);
                if(exist){
                  return GestureDetector(
                    onTap: (){
                      myBox.delete(food);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted!'))
                      );
                    },
                      child: Icon(Icons.done,color: Colors.green,size: w*.07,));
                }
                else{
                  return GestureDetector(
                    onTap: (){
                      String value='$food $measure $quantity';
                      myBox.put(food, value);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Added succesfully!')));
                    },
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      size: w * .07,
                      color: Colors.red,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
