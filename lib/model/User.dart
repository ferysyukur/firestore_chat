class User{
  String uid;
  String displayName;
  String photoUrl;

//  User(this.uid, this.displayName, this.photoUrl);

  User.fromMap(Map<String, dynamic> map)
    :
      uid = map["uid"],
      displayName = map["displayName"],
      photoUrl = map["photoUrl"];

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'displayName': displayName,
      'photoUrl': photoUrl
    };
  }
}