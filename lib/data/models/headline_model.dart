class HeadlineModel {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  HeadlineModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory HeadlineModel.fromJson(Map<String, dynamic> json) {
    return HeadlineModel(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'],
      content: json['content'] ?? "",
    );
  }
}

class Source {
  final String? name;

  Source({
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json['name'] ?? "",
    );
  }
}
