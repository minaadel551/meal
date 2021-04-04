import 'package:flutter/material.dart';
import './models/category.dart';
import './models/meal.dart';


// دي قائمة كونت فيها ال categories اللي عندي
// وهو بياخد object من class ال Category
// يعني الفئات اللي هتظهر اول صفحة البرنامج
const DUMMY_CATEGORIES = const [
  Category(
    id: 'c1',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    color: Colors.teal,
  ),
];



// دي قائمة كونت فيها ال meals اللي عندي
// وهو بياخد object من class ال Meal
// يعني الوجبات اللي هتظهر اول اما اختار الفئة اللي عاوزها
const DUMMY_MEALS = const [
  Meal(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageUrl:
    'assets/images/Spaghetti.jpg',
    duration: 20,


    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm2',
    categories: [
      'c2',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageUrl:
    'assets/images/toast.jpg',
    duration: 10,

    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm3',
    categories: [
      'c2',
      'c3',
    ],
    affordability: Affordability.Pricey,
    complexity: Complexity.Simple,
    imageUrl:
    'assets/images/burger.jpg',
    duration: 45,

    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm4',
    categories: [
      'c4',
    ],
    affordability: Affordability.Luxurious,
    complexity: Complexity.Challenging,
    imageUrl:
    'assets/images/schnitzel.jpg',
    duration: 60,
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm5',
    categories: [
      'c2'
          'c5',
      'c10',
    ],
    affordability: Affordability.Luxurious,
    complexity: Complexity.Simple,
    imageUrl:
    'assets/images/smoked-salmon-salad.jpg',
    duration: 15,

    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm6',
    categories: [
      'c6',
      'c10',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Hard,
    imageUrl:
    'assets/images/pastry.jpg',
    duration: 240,
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm7',
    categories: [
      'c7',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Simple,
    imageUrl:
    'assets/images/pancake.jpg',
    duration: 20,

    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm8',
    categories: [
      'c8',
    ],
    affordability: Affordability.Pricey,
    complexity: Complexity.Challenging,
    imageUrl:
    'assets/images/indian-food.jpg',
    duration: 35,

    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
  ),
  Meal(
    id: 'm9',
    categories: [
      'c9',
    ],
    affordability: Affordability.Affordable,
    complexity: Complexity.Hard,
    imageUrl:
    'assets/images/souffle.jpg',
    duration: 45,

    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
  ),
  Meal(
    id: 'm10',
    categories: [
      'c2',
      'c5',
      'c10',
    ],
    affordability: Affordability.Luxurious,
    complexity: Complexity.Simple,
    imageUrl:
    'assets/images/asparagus.jpg',
    duration: 30,

    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
];

