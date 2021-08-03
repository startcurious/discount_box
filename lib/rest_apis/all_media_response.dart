import 'media_response.dart';

class AllMediaResponse {
  List<media_response> productList;

  AllMediaResponse({this.productList});

  AllMediaResponse.getData(var li) {
    productList = new List<media_response>();

    li.forEach((v) {
      productList.add(new media_response.fromJson(v));
    });
  }

  AllMediaResponse.fromJson(Map<String, dynamic> json) {
    if (json['product_tag'] != null) {
      productList = new List<media_response>();
      json['product_tag'].forEach((v) {
        productList.add(new media_response.fromJson(v));
      });
    }
  }
}
