class Data {
  Table? table;

  Data({this.table});

  Data.fromJson(Map<String, dynamic> json) {
    table = json['Table'] != null ? new Table.fromJson(json['Table']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.toJson();
    }
    return data;
  }
}

class Table {
  Driver1? driver1;

  Table({this.driver1});

  Table.fromJson(Map<String, dynamic> json) {
    driver1 =
    json['Driver1'] != null ? new Driver1.fromJson(json['Driver1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver1 != null) {
      data['Driver1'] = this.driver1!.toJson();
    }
    return data;
  }
}

class Driver1 {
  String? images;
  String? name;

  Driver1({this.images, this.name});

  Driver1.fromJson(Map<String, dynamic> json) {
    images = json['Images'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Images'] = this.images;
    data['Name'] = this.name;
    return data;
  }
}
