import 'package:flutter/material.dart';
import 'package:meal/models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class MealProvider extends ChangeNotifier{

  Map <String,bool> filters={
    'isGlutenFree' : false,
    'isVegan' : false,
    'isVegetarian' : false,
    'isLactoseFree' : false,};

  List<Meal> availableMeals=DUMMY_MEALS;
  List<Meal> favoriteMeal=[];

  List<String>prefsMealId = [];

  List<Category> availableCategory=[];


  void setFilters ()async{

    availableMeals=DUMMY_MEALS.where((meal) {
      if(filters['isGlutenFree']&& meal.isGlutenFree ) return false ;
      if(filters['isVegan']&& meal.isVegan ) return false ;
      if(filters['isVegetarian']&& meal.isVegetarian ) return false ;
      if(filters['isLactoseFree']&& meal.isLactoseFree ) return false ;
      return true;
    }).toList();

    List<Category> ac =[];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(cat.id == catId) {
            if(!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    availableCategory = ac;

  notifyListeners();

  SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setBool('isGlutenFree', filters['isGlutenFree']);
    prefs.setBool('isVegan', filters['isVegan']);
    prefs.setBool('isVegetarian', filters['isVegetarian']);
    prefs.setBool('isLactoseFree', filters['isLactoseFree']);

  }

 void getData()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  filters['isGlutenFree'] = prefs.getBool('isGlutenFree') ?? false;
  filters['isVegan'] = prefs.getBool('isVegan') ?? false;
  filters['isVegetarian'] = prefs.getBool('isVegetarian') ?? false;
  filters['isLactoseFree'] = prefs.getBool('isLactoseFree') ?? false;

  List<String>prefsMealId = prefs.getStringList('prefsMealId') ?? [];
  for (var mealId in prefsMealId) {
    final existingIndex = favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex < 0) {
      favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }
}


  void toggleFavorites(String mealId)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();

    final existingIndex =favoriteMeal.indexWhere((meal) => meal.id==mealId);
    if(existingIndex >=0){
      favoriteMeal.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    }
    else{
      favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) =>meal.id==mealId));
      prefsMealId.add(mealId);
    }
    notifyListeners();
    prefs.setStringList('prefsMealId', prefsMealId);
  }


  bool isMealFavorite (String mealId){
    return favoriteMeal.any((meal) => meal.id == mealId);
  }
}

