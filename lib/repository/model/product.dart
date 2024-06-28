class ProductItem {
  int? id;
  String? title;
  String? brand;
  double? price;
  double? rating;
  int? reviews;

  ProductItem({
    this.id,
    this.title,
    this.brand,
    this.price,
    this.rating,
    this.reviews,
  });

  ProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    brand = json['brand'];
    price = json['price'];
    rating = json['rating'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['title'] = title;
    data['brand'] = brand;
    data['price'] = price;
    data['rating'] = rating;
    data['reviews'] = reviews;
    return data;
  }
}
