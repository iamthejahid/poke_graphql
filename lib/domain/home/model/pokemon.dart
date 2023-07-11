class Pokemon {
  final String? typename;
  final String? id;
  final String? name;
  final Eight? weight;
  final Eight? height;
  final String? image;
  final String? classification;

  Pokemon({
    this.typename,
    this.id,
    this.name,
    this.weight,
    this.height,
    this.image,
    this.classification,
  });

  Pokemon copyWith({
    String? typename,
    String? id,
    String? name,
    Eight? weight,
    Eight? height,
    String? image,
    String? classification,
  }) =>
      Pokemon(
        typename: typename ?? this.typename,
        id: id ?? this.id,
        name: name ?? this.name,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        image: image ?? this.image,
        classification: classification ?? this.classification,
      );

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        typename: json["__typename"],
        id: json["id"],
        name: json["name"],
        weight: json["weight"] == null ? null : Eight.fromJson(json["weight"]),
        height: json["height"] == null ? null : Eight.fromJson(json["height"]),
        image: json["image"],
        classification: json["classification"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id": id,
        "name": name,
        "weight": weight?.toJson(),
        "height": height?.toJson(),
        "image": image,
        "classification": classification,
      };
}

class Eight {
  final String? typename;
  final String? maximum;

  Eight({
    this.typename,
    this.maximum,
  });

  Eight copyWith({
    String? typename,
    String? maximum,
  }) =>
      Eight(
        typename: typename ?? this.typename,
        maximum: maximum ?? this.maximum,
      );

  factory Eight.fromJson(Map<String, dynamic> json) => Eight(
        typename: json["__typename"],
        maximum: json["maximum"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "maximum": maximum,
      };
}
