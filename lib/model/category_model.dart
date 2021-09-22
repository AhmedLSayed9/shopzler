class CategoryModel {
  late String name, image;

  CategoryModel({
    required this.name,
    required this.image,
  });

  CategoryModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
    };
  }
}
