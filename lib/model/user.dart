class User {
  String username;
  String imageUrl;
  final String description;
  int followers;
  int followings;
  int public_repo;
  String joined_date;

  User({
    this.description,
    this.username,
    this.imageUrl,
    this.joined_date,
    this.followers,
    this.followings,
    this.public_repo,
  });
}
