import 'package:flutter/material.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final List favoritesMeal = Provider.of<MealProvider>(context).favoriteMeal ;
    bool islandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan =Provider.of<LanguageProvider>(context,listen: true);

    if(favoritesMeal.isEmpty)
      return Center(
       child: Text(lan.getTexts('favorites_text')),
     );
     else{
       return GridView.builder(
           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
               maxCrossAxisExtent: ( dw<= 400)?400:500,
               childAspectRatio: islandScape? dw/(dw*0.82):dw/(dw*0.75),
               crossAxisSpacing: 0,
               mainAxisSpacing: 0
           ),
           itemCount: favoritesMeal.length,
           itemBuilder: (context, index) => MealItem(
             id: favoritesMeal[index].id,
             duration: favoritesMeal[index].duration,
             affordability: favoritesMeal[index].affordability,
             complexity: favoritesMeal[index].complexity,
             imageUrl: favoritesMeal[index].imageUrl,)
       );
     }
  }
}
