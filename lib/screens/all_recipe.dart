import 'package:flutter/material.dart';
import 'package:recipe_app/components/custom_appbar.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/constants/constant_function.dart';
import 'package:recipe_app/screens/details_screen.dart';

class AllRecipe extends StatefulWidget {
  final String recipe;
  AllRecipe({super.key, required this.recipe});

  @override
  State<AllRecipe> createState() => _AllRecipeState();
}

class _AllRecipeState extends State<AllRecipe> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.recipe,
        back: true,
      ),
      body: FutureBuilder(
          future: ConstantFunction.getResponse(widget.recipe),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No Data'),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                right: w * .034,
                left: w * .034,
                top: h * .034,
              ),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: .6 / 1,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> snap = snapshot.data![index];
                    int time = snap['totalTime'].toInt();

                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.red.shade200,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                        item: snap,
                                                      )));
                                        },
                                        child: Container(
                                          height: 200,
                                          width: 180,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image:
                                                    NetworkImage(snap['image']),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),

                                      //Yaha se maine positionad widhgt ko hataya aur column ke bahar sset kiya hain
                                    ],
                                  ),
                                  Positioned(
                                      top: 7,
                                      left: 15,
                                      child: Container(
                                        height: 20,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${time.toString()} min',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  left: 6,
                                ),
                                child: Text(
                                  snap['label'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: w * .04),
                                ),
                              ))
                        ],
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
