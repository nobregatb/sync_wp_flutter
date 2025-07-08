class Tag {
  final int id;
  String tagName;
  String tagIcon;
  String tagColor;
  int count;

  Tag({
    required this.id,
    required this.tagName,
    required this.tagIcon,
    required this.tagColor,
    required this.count,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['tag_id'] ?? 0,
      tagName: json['tag_name'] ?? '',
      tagIcon: json['tag_icon'] ?? 'fas fa-tag',
      tagColor: json['tag_color'] ?? '#000000',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tag_name': tagName,
      'tag_icon': tagIcon,
      'tag_color': tagColor,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'Tag{id: $id, tag_name: $tagName, tag_icon: $tagIcon, tag_color: $tagColor, count: $count}';
  }
}