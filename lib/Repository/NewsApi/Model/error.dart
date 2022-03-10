class NewsApiError {
  final String? code, message;

  NewsApiError(this.code, this.message);

  factory NewsApiError.fromJson(Map<String, dynamic> json) {
    return NewsApiError(
      json["code"],
      json["message"],
    );
  }
}
