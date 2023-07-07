import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class Category {
  final String icon;
  final String title;

  Category({required this.icon, required this.title});
}

List<Category> demoCategories = [
  Category(
    icon: "assets/icons/electronics.svg",
    title: "Electronics",
  ),
  Category(
    icon: "assets/icons/sports.svg",
    title: "Sports",
  ),
  Category(
    icon: "assets/icons/tools.svg",
    title: "Tools",
  ),
  Category(
    icon: "assets/icons/clothes.svg",
    title: "Clothes",
  ),
  Category(
    icon: "assets/icons/music.svg",
    title: "Music",
  ),
  Category(
    icon: "assets/icons/vehicles.svg",
    title: "Vehicles",
  ),
  Category(
    icon: "assets/icons/party.svg",
    title: "Party",
  ),
  Category(
    icon: "assets/icons/videogames.svg",
    title: "Video games",
  ),
  Category(
    icon: "assets/icons/furniture.svg",
    title: "Furniture",
  ),
];

class Categories extends StatefulWidget {
  final List<Category> categories;
  final void Function(int) onCategorySelected;

  const Categories({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.categories.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onCategorySelected(index); // Pass the index here
            },
            child: CategoryCard(
              category: widget.categories[index],
              isSelected: _selectedIndex == index,
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: isSelected ? Color.fromARGB(255,226, 183, 19) : Color.fromARGB(255, 54, 55, 59),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: kPrimaryColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: SvgPicture.asset(
              category.icon,
              color: isSelected ? Colors.black: Color.fromARGB(255,226, 183, 19),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          category.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Color.fromARGB(255,226, 183, 19) : Color.fromARGB(255,226, 183, 19)
          ),
        ),
      ],
    );
  }
}
