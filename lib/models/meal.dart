

import 'package:flutter/foundation.dart';

enum Complexity{Simple,Challenging,Hard}
enum Affordability{Affordable,Pricey,Luxurious}

// دا كلاس علشان الوجبات اللي عندي
// هاخد منو object وجبة جديدة
// بتيجي لما بختار من class ال category

class Meal{
  final String id,imageUrl;
  final bool isGlutenFree, isVegan, isVegetarian, isLactoseFree ;
  final int duration;
  final List<String> categories;
  final Complexity complexity;
  final Affordability affordability;

  const Meal({ @required this.affordability, @required this.complexity,
    @required this.duration, @required this.id, @required this.categories,
    @required this.isGlutenFree, @required this.imageUrl,
    @required this.isLactoseFree, @required this.isVegan, @required this.isVegetarian,
    });

}