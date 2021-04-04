import 'package:flutter/material.dart';
import 'package:meal/providers/language_provider.dart';
import '../models/meal.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal_item.dart';



class CategoryMealScreen extends StatefulWidget {
  static const routeName='category_meal_screen';
 

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}



class _CategoryMealScreenState extends State<CategoryMealScreen> {

  String categoryID;
  List <Meal> displayedMeal ;

  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals = Provider.of<MealProvider>(context).availableMeals ;
     final routeArgument =ModalRoute.of(context).settings.arguments as Map<String,String>;
         categoryID= routeArgument['id'];


     displayedMeal = availableMeals.where((meal){
          return meal.categories.contains(categoryID);
        }).toList();
    super.didChangeDependencies();
  }


  removeMeal(String mealId){
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });
  }


  @override
  Widget build(BuildContext context) {
    bool islandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var lan =Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lan.getTexts('cat-$categoryID')),),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:( dw<= 400)?400:500,
                childAspectRatio: islandScape? dw/(dw*0.77):dw/(dw*0.70),
                crossAxisSpacing: 0,
                mainAxisSpacing: 0
            ),
          itemCount: displayedMeal.length,
          itemBuilder: (context, index) => MealItem(
            id: displayedMeal[index].id,
            duration: displayedMeal[index].duration,
              affordability: displayedMeal[index].affordability,
            complexity: displayedMeal[index].complexity,
          imageUrl: displayedMeal[index].imageUrl,)
        )
      ),
    );
  }
}
