
class listModel {
  
  String personName;
  String personImage;
  String address;
  String message;
  String messageImage;
  int likesCount;
  int commentsCount;
  String postTime;
  List<String> photos;

  listModel({
    this.personName,
    this.personImage,
    this.address,
    this.message,
    this.messageImage,
    this.likesCount,
    this.commentsCount,
    this.postTime,
    this.photos,
  });
}