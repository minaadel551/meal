import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/providers/language_provider.dart';
import 'package:meal/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName='meal_screen';



  Widget buildText({BuildContext ctx, String text}){
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 10),
      child: Text(text,style: Theme.of(ctx).textTheme.headline6,textAlign: TextAlign.center,),
    );
  }

  Widget buildContainer({Widget child}){

    return  Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 3),
      height: 150,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:Colors.grey),
        borderRadius: BorderRadius.circular(15),),
      child: child
    );
  }



  @override
  Widget build(BuildContext context) {
    bool isLandScape= MediaQuery.of(context).orientation == Orientation.landscape;
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((index) => index.id ==mealId);
    var accentColor =Theme.of(context).accentColor;

    var lan =Provider.of<LanguageProvider>(context,listen: true);

    List<String> ingredientliLi=lan.getTexts('ingredients-$mealId') as List<String>;
    var listIngredients = ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: ingredientliLi.length,
      itemBuilder: (context, index) => Card(
        color: accentColor,
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical:6,horizontal: 5),
          child: Text(ingredientliLi[index],
              style: TextStyle(color:Colors.black)),
        ),
      ),
    );

    List<String> stepsli=lan.getTexts('steps-$mealId') as List<String>;
    var listSteps =ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: stepsli.length,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,
                child: Text('#${index+1}',style: TextStyle(color: Colors.white),),radius: 15,),
              title: Text(stepsli[index],style: TextStyle(color: Colors.black),),

            ),
            Divider()
          ],
        )
    );



    return Directionality(
      textDirection: lan.isEn ?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(lan.getTexts('meal-$mealId')),
                background:Hero(
                    tag: mealId,
                    child: InteractiveViewer(
                        child:Image.asset(selectMeal.imageUrl,fit: BoxFit.cover,),
                    )
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([

                if(isLandScape) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        buildText(ctx: context,text:lan.getTexts('Ingredients')),
                        buildContainer(child:listIngredients ),
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        buildText(ctx: context,text:lan.getTexts('Steps')),
                        buildContainer(child: listSteps),
                      ],
                    ),
                  ],
                ),

                if(!isLandScape) buildText(ctx: context,text:lan.getTexts('Ingredients')),
                if(!isLandScape) buildContainer(child:listIngredients ),
                if(!isLandScape) buildText(ctx: context,text:lan.getTexts('Steps')),
                if(!isLandScape) buildContainer(child: listSteps),

              ]),
            ),
          ],

        ),
        floatingActionButton: FloatingActionButton(
          onPressed:()=>Provider.of<MealProvider>(context,listen: false).toggleFavorites(mealId),
          child: Icon(Provider.of<MealProvider>(context,listen: true).isMealFavorite(mealId)?
                Icons.star:Icons.star_border),
          elevation: 0,
          ),
      ),
    );
  }
}
