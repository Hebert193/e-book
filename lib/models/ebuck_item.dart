class EBuckItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  EBuckItem({required this.id, required this.title, required this.description, required this.imageUrl});

  factory EBuckItem.fromJson(Map<String, dynamic> json) => EBuckItem(
    id: json['id'].toString(),
    title: json['title'] ?? 'Sem título',
    description: json['body'] ?? json['description'] ?? '',
    imageUrl: json['image'] ?? '',
  );
}