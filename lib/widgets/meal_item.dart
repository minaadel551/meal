import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/screen/meal_detail_screen.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
// دا كلاس علشان انسق الشكل اللي هيتعرض بيه الوجبات لما اضغط علي الفئات

class MealItem extends StatelessWidget {
  final String  imageUrl,id;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({@required this.imageUrl,@required this.duration,
    @required this.complexity,@required this.affordability,@required this.id});



  // String get complexityText{
  //   switch (complexity){
  //     case Complexity.Simple :return 'Simple'; break;
  //     case Complexity.Challenging :return 'Challenging'; break;
  //     case Complexity.Hard :return 'Hard'; break;
  //     default :return 'UnKnown'; break;
  //   }
  // }
  // String get affordabilityText{
  //   switch (affordability){
  //     case Affordability.Affordable :return 'Affordable'; break;
  //     case Affordability.Luxurious :return 'Luxurious'; break;
  //     case Affordability.Pricey :return 'Pricey'; break;
  //     default :return 'UnKnown'; break;
  //   }
  // }
  
  void selectMeal(BuildContext context){
    Navigator.pushNamed(context, MealDetailScreen.routeName,arguments:id).
    then((value) {
      if (value != null){
      //  removeItem(value);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var lan =Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap:()=>selectMeal(context),
       child: Card(
         elevation: 4,
         shadowColor: Theme.of(context).accentColor,
         margin: EdgeInsets.all(10),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.only(
             topLeft: Radius.circular(15),
             topRight: Radius.circular(15)
           )
         ),
         child: Column(
           children: [
             Stack(
               children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(15),
                   child: Hero(
                     tag: id,
                       child: Image.asset(imageUrl,height: 200,width: double.infinity,fit: BoxFit.fill,),
                   ),
                 ),
                 Positioned(
                   right: 10,
                   bottom: 20,
                   child: Container(
                      width: 300,
                     decoration: BoxDecoration(
                         color: Colors.black54,
                         borderRadius: BorderRadius.circular(8)),
                     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                     child: Text(lan.getTexts('meal-$id'),style: TextStyle(color: Colors.white,fontSize:24),softWrap: true,overflow: TextOverflow.fade,),
                   ),
                 )

               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 RowWidget(text:'$duration' + lan.getTexts('min'),icon:Icons.schedule ,),
                 RowWidget(text: lan.getTexts('$complexity'),icon:Icons.work ,),
                 RowWidget(text:lan.getTexts('$affordability'),icon:Icons.attach_money ,),

               ],
             )
           ],
         )
       ),
      ),
    );
  }
}



class RowWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  RowWidget({@required this.text,this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: Theme.of(context).buttonColor,),
        Text('$text'),
      ],
    );
  }
}
