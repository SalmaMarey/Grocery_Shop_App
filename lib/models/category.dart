enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,

  other
}

class Category {
  final String title;
  final String imageUrl;

  const Category({
    required this.title,
    required this.imageUrl,
  });
}
