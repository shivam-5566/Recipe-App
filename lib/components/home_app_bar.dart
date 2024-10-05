import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('What are you\ncooking today',style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*.07,height: 1),),
        const Spacer(),
        const CircleAvatar(backgroundColor: Colors.red,child: Text('S',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),)

      ],
    );
  }
}
