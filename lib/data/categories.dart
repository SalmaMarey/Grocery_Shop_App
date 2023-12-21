import '../models/category.dart';

Map<Categories, Category> categories = {
  Categories.vegetables: const Category(
    title: 'Vegetables',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/2153/2153788.png',
  ),
  Categories.fruit: const Category(
    title: 'Fruit',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/1625/1625099.png',
  ),
  Categories.meat: const Category(
    title: 'Meat',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3143/3143643.png',
  ),
  Categories.dairy: const Category(
    title: 'Dairy',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/2674/2674505.png',
  ),
  Categories.carbs: const Category(
    title: 'Carbs',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/5953/5953781.png',
  ),
  Categories.sweets: const Category(
    title: 'Sweets',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/2454/2454271.png',
  ),
  Categories.spices: const Category(
    title: 'Spices',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/4293/4293152.png',
  ),
  Categories.other: const Category(
    title: 'Other',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3357/3357272.png',
  ),
};
