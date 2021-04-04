import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return
      GridView(
      padding: EdgeInsets.all(5),
      children: Provider.of<MealProvider>(context).availableCategory
          .map((index) => CategoryItem(
          id: index.id, color: index.color)).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3/2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
      ),
    );
  }
}
