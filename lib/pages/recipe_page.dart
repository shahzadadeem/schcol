import 'package:flutter/material.dart';
import 'package:schcol/models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe item;
  const RecipePage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.transparent,
        title: const Text('Recipe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _recipeImage(context),
            _recipeDetails(context),
            _ingredients(context),
            _instructions(context)
          ],
        ),
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.35,
      width: MediaQuery.sizeOf(context).width,
      child: Image.network(
        item.image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _recipeDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey.shade200,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${item.cuisine}, ${item.difficulty}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Prep Time: ${item.prepTimeMinutes} Min | Cook Time: ${item.cookTimeMinutes} Min",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "${item.rating} ⭐ |  ${item.reviewCount} Reviews | Best for ${item.mealType[0]}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _ingredients(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Ingredients:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...item.ingredients.map((e) {
            return Row(
              children: [
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                ),
                Text(
                  e.toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _instructions(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Instructions:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...item.instructions.map((e) {
            return Text(
              "${item.instructions.indexOf(e) + 1} - ${e}",
              style: TextStyle(fontSize: 16),
            );
          }),
        ],
      ),
    );
  }
}
