
class ColombiaItem {
  final int id;
  final String name;
  final String description;
  final Map<String, dynamic> data;

  const ColombiaItem({
    required this.id,
    required this.name,
    required this.description,
    required this.data,
  });

  factory ColombiaItem.fromJson(Map<String, dynamic> json) {
    return ColombiaItem(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse('${json['id']}') ?? 0,
      name: (json['name'] ?? json['title'] ?? 'Sin nombre').toString(),
      description: (json['description'] ?? '').toString(),
      data: json,
    );
  }
}
