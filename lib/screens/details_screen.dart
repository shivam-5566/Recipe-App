import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/components/circle_button.dart';
import 'package:recipe_app/components/custom_clip_path.dart';
import 'package:recipe_app/components/ingredient_list.dart';
import 'package:recipe_app/constants/share_screen.dart';
import 'package:recipe_app/constants/show_category_dialog.dart';
import 'package:recipe_app/constants/show_table.dart';
import 'package:recipe_app/constants/start_cooking.dart';
import 'package:hive/hive.dart';
class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const DetailsScreen({super.key, required this.item});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    String time = widget.item['totalTime'].toString();
    // Yahan par maine 'shopping ko 'saved' se replace kiya hain kyonki error aa raha tha!
    var myBox = Hive.box('shopping');
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: h * .44,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.item['image']),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                    top: h * .04,
                    left: w * .05,
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: BackButton(
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.item['label'],
                    style: TextStyle(
                        fontSize: w * .05,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text('$time min'),
                  SizedBox(
                    height: h * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            ShareRecipe.share(widget.item['url']);
                          },
                          child: const CircleButton(
                            icon: Icons.share,
                            label: 'Share',
                          )),
                      ValueListenableBuilder(
                          valueListenable: myBox.listenable(),
                          builder: (context, box, _) {
                            String key = widget.item['label'];
                            bool saved = myBox.containsKey(key);
                            if (saved) {
                              return GestureDetector(
                                  onTap: () {
                                    myBox.delete(key);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(duration: Duration(seconds: 1),
                                            content: Text('Recipe deleted')));
                                  },
                                  child: const CircleButton(
                                    icon: Icons.bookmark,
                                    label: 'Saved',
                                  ));
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    myBox.put(key, key);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(duration: Duration(seconds: 1),
                                            content: Text(
                                                'Recipe saved succesfully')));
                                  },
                                  child: const CircleButton(
                                    icon: Icons.bookmark_border,
                                    label: 'Save',
                                  ));
                            }
                          }),
                      GestureDetector(
                          onTap: () {
                            ShowDialog.showCalories(widget.item['totalNutrients'], context
                               );
                          },
                          child: const CircleButton(
                            icon: Icons.monitor_heart_outlined,
                            label: 'Calories',
                          )),
                      GestureDetector(
                          onTap: () {
                            ShowTable.showTable(context);
                          },
                          child: const CircleButton(
                            icon: Icons.table_chart_outlined,
                            label: 'Unit chart',
                          ))
                    ],
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Direction',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: w * .06),
                      ),
                      SizedBox(
                        width: w * .34,
                        child: ElevatedButton(
                            onPressed: () {
                              StartCooking.startCooking(widget.item['url']);
                            },
                            child: const Text('Start')),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  Container(
                    height: h * .07,
                    width: w,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: ClipPath(
                              clipper: CustomClipPath(),
                              child: Container(
                                color: Colors.redAccent,
                                child: Center(
                                  child: Text(
                                    'Ingredients Required',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: w * .05),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: const Center(
                                child: Text(' 6\nItems'),
                              ),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  SizedBox(
                    height: h * 1.8,
                    child:
                        IngredientList(ingredients: widget.item['ingredients']),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
