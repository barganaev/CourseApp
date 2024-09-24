class Course {
  final int? id;
  final String title;
  final String subtitle;
  final String description;

  Course(this.title, this.subtitle, this.description, {this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }
}