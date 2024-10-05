import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/components/custom_appbar.dart';
import 'package:hive/hive.dart';
import 'package:recipe_app/constants/share_screen.dart';
class SavedScreen extends StatelessWidget {
   const SavedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('shopping');
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Saved',back: false,),
      body: Padding(padding: const EdgeInsets.only(top: 10,right: 8,left: 8),
      child: ValueListenableBuilder(
        valueListenable:myBox.listenable() ,
        builder: (context,box,_ ){
          return ListView.builder(
            itemCount: box.length,
              itemBuilder: (context, index){
             var data = box.values.toList();
             return ListTile(
               title: Container(
                 height: h*.085,
                 color: Colors.grey[100],
                 child:Row(
                   children: [
                     Expanded(flex: 3,
                         child: Text(data[index])),
                     PopupMenuButton(itemBuilder: (context){
                       return [
                         PopupMenuItem(value:'share',child: Text('share')),
                         PopupMenuItem(value:'delete',child: Text('delete'))
                       ];
                     },
                       onSelected: (String value){
                         if(value=='delete'){
                           deleteItem(index);
                         }else if(value=='share'){
                           ShareRecipe.share(data[index]);
                         }
                       },
                     )
                   ],
                 ),

               ),
             );
          });
        },
      ),),
    );
  }
   Future<void> deleteItem(int index)async{
     var myBox = Hive.box('shopping');
     await myBox.deleteAt(index);
   }
}
