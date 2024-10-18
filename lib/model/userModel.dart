class UserModel {
  String image;
  String id;
  double price;
  bool delete;
  String name;

  UserModel({
    required this.image,
    required this.id,
    required this.delete,
    required this.price,
    required this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      "image": this.image,
      "id": this.id,
      "delete": this.delete,
      "price": this.price,
      "name": this.name
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      image: map["image"] ?? "",
      id: map["id"] ?? "",
      delete: map["delete"] ?? "",
      price: map["price"] ?? "",
      name: map["name"] ?? "",
    );
  }
  UserModel copyWith({String? image, String? category, String? id, bool? delete,  double? price,  String? name}) {
    return UserModel(
      image: image ?? this.image,
      id: id ?? this.id,
      delete: delete??this.delete,
      price: price ?? this.price,
      name: name ?? this.name,
    );
  }
}
