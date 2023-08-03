class Streammodel {
  Streammodel({
      this.title, 
      this.description, 
      this.url, 
      this.date,});

  Streammodel.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    url = json['url'];
    date = json['date'];
  }
  String? title;
  String? description;
  String? url;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['date'] = date;
    return map;
  }
  static List<Streammodel> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => Streammodel.fromJson(value)).toList();
  }}
