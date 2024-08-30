class TodoModel {
  String? description;
  String? id;
  bool? isComplete;

  TodoModel({
    this.description,
    this.id,
    this.isComplete,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        description: json["description"],
        id: json["id"],
        isComplete: json["isComplete"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "id": id,
        "isComplete": isComplete,
      };
}
