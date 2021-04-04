import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import 'package:provider/provider.dart';
import '../screen/category_meal_screen.dart';

// دا علشان ينسقلي الcontainer اللي هعرض فيه الفئات
class CategoryItem extends StatelessWidget {
   String id;
   Color color;
   CategoryItem({ @required this.id, @required this.color,});

   void selectCategory(BuildContext ctx){
Navigator.of(ctx).pushNamed(CategoryMealScreen.routeName,arguments: {
  'id':id });
   }


  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);

    return InkWell(
      onTap: ()=>selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        child: Text(lan.getTexts('cat-$id'),style: Theme.of(context).textTheme.headline6,),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.1),
              color
            ]
          )
        )
      ),
    );
  }
}
