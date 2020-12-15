
class Photo {
  int id=0;
  bool isSaved=false;
  int saved;
  String photo_name;
  String wear;
  bool selection=false;


  Photo({this.id, this.photo_name, this.saved,this.wear});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photo_name,
      'saved':saved
      ,'wear':wear
    };
    print("object$saved");
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photo_name = map['photo_name'];
    isSaved=map['saved']==0?false:true;
    wear=map['wear'];
    print("object${map['saved']}");
  }
}