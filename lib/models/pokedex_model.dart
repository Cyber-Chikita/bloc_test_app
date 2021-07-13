const countLabel = "label";
const previousLabel = "previous";
const nextLabel = "next";
const resultsLabel = "results";
const nameLabel = "name";

class Pokedex {
  final int? count;
  final String? previous;
  final String? next;
  final List<String>? name;

  Pokedex({this.count, this.previous, this.next, this.name});

  Pokedex.formJson(Map<String, dynamic> json)
      : count = json[countLabel],
        previous = json[previousLabel],
        next = json[nextLabel],
        name = _getStringArray(json[resultsLabel]);

  static List<String> _getStringArray(List<dynamic> nameList) {
    List<String> list = [];
    nameList.forEach((element) {
      list.add(element[nameLabel]);
    });
    return list;
  }
}
