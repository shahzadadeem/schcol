import 'package:flutter/material.dart';
import 'package:schcol/models/recipe.dart';
import 'package:schcol/pages/recipe_page.dart';
import 'package:schcol/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eat Healthy"),
        actions: [
          IconButton.filled(
              onPressed: () {
                setState(() {
                  filter = "";
                });
              },
              icon: Icon(Icons.refresh_sharp))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _recepeTypeButtons(),
            _recipesListView(),
          ],
        ),
      ),
    );
  }

  Widget _recepeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      width: MediaQuery.sizeOf(context).width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    filter = "snack";
                  });
                },
                child: Text("🫰 Snack")),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    filter = "breakfast";
                  });
                },
                child: Text("🍳Breakfast")),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    filter = "lunch";
                  });
                },
                child: Text("🍚Lunch")),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    filter = "dinner";
                  });
                },
                child: Text("🍽️Dinner")),
          ),
        ],
      ),
    );
  }

  Widget _recipesListView() {
    return Expanded(
      child: FutureBuilder(
        future: DataService().getRecipes(filter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something is wrong, Can't get data"),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Recipe item = snapshot.data![index];
                return Card.filled(
                  child: ListTile(
                    minVerticalPadding: 15,
                    isThreeLine: true,
                    leading: Image.network(item.image),
                    title: Text(item.name),
                    subtitle:
                        Text("${item.cuisine}\nDifficulty: ${item.difficulty}"),
                    trailing: Text(
                      "${item.rating.toString()} ⭐",
                      style: TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipePage(item: item),
                          ));
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
