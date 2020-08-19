import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CateegoryMealsScreen extends StatefulWidget {
  static const route = '/category-meals';

  final List<Meal> meals;

  CateegoryMealsScreen(this.meals);

  @override
  _CateegoryMealsScreenState createState() => _CateegoryMealsScreenState();
}

class _CateegoryMealsScreenState extends State<CateegoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'];
      final _categoryId = routeArgs['id'];
      _displayedMeals = widget.meals
          .where((meal) => meal.categories.contains(_categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: _displayedMeals[index].id,
          title: _displayedMeals[index].title,
          imageUrl: _displayedMeals[index].imageUrl,
          duration: _displayedMeals[index].duration,
          complexity: _displayedMeals[index].complexity,
          affordability: _displayedMeals[index].affordability,
        ),
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
