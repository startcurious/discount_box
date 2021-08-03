

class ProductResponse{
  List<product> productList;

  ProductResponse({
    this.productList
  });

  ProductResponse.getData(var li){
    productList = new List<product>();

    li.forEach((v) {
      productList.add(new product.fromJson(v));
    });
  }

  ProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['product_tag'] != null) {
      productList = new List<product>();
      json['product_tag'].forEach((v) {
        productList.add(new product.fromJson(v));
      });
    }
  }

}

class product {
  int id;
  String date;
  String dateGmt;
  Guid guid;
  String modified;
  String modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Guid title;
  Content content;
  Content excerpt;
  int featuredMedia;
  String commentStatus;
  String pingStatus;
  String template;
  Meta meta;
  List<int> productCat;
  List<int> productTag;
  Links lLinks;

  product(
      {this.id,
        this.date,
        this.dateGmt,
        this.guid,
        this.modified,
        this.modifiedGmt,
        this.slug,
        this.status,
        this.type,
        this.link,
        this.title,
        this.content,
        this.excerpt,
        this.featuredMedia,
        this.commentStatus,
        this.pingStatus,
        this.template,
        this.meta,
        this.productCat,
        this.productTag,
        this.lLinks});

  product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? new Guid.fromJson(json['guid']) : null;
    modified = json['modified'];
    modifiedGmt = json['modified_gmt'];
    slug = json['slug'];
    status = json['status'];
    type = json['type'];
    link = json['link'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    excerpt =
    json['excerpt'] != null ? new Content.fromJson(json['excerpt']) : null;
    featuredMedia = json['featured_media'];
    commentStatus = json['comment_status'];
    pingStatus = json['ping_status'];
    template = json['template'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    productCat = json['product_cat'].cast<int>();
    if (json['product_tag'] != null) {
      productTag = new List<int>();
      json['product_tag'].forEach((v) {
        productTag.add(v);
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['date_gmt'] = this.dateGmt;
    if (this.guid != null) {
      data['guid'] = this.guid.toJson();
    }
    data['modified'] = this.modified;
    data['modified_gmt'] = this.modifiedGmt;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['type'] = this.type;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    if (this.excerpt != null) {
      data['excerpt'] = this.excerpt.toJson();
    }
    data['featured_media'] = this.featuredMedia;
    data['comment_status'] = this.commentStatus;
    data['ping_status'] = this.pingStatus;
    data['template'] = this.template;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['product_cat'] = this.productCat;
    if (this.productTag != null) {
      data['product_tag'] = this.productTag.map((v) => v).toList();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

class Guid {
  String rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Content {
  String rendered;
  bool protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}

class Meta {
  String spayEmail;

  Meta({this.spayEmail});

  Meta.fromJson(Map<String, dynamic> json) {
    spayEmail = json['spay_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spay_email'] = this.spayEmail;
    return data;
  }
}

class Links {
  List<Self> self;
  List<Self> collection;
  List<Self> about;
  List<Replies> replies;
  List<Replies> wpFeaturedmedia;
  List<Self> wpAttachment;
  List<WpTerm> wpTerm;
  List<Curies> curies;

  Links(
      {this.self,
        this.collection,
        this.about,
        this.replies,
        this.wpFeaturedmedia,
        this.wpAttachment,
        this.wpTerm,
        this.curies});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = new List<Self>();
      json['self'].forEach((v) {
        self.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = new List<Self>();
      json['collection'].forEach((v) {
        collection.add(new Self.fromJson(v));
      });
    }
    if (json['about'] != null) {
      about = new List<Self>();
      json['about'].forEach((v) {
        about.add(new Self.fromJson(v));
      });
    }
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
    if (json['wp:featuredmedia'] != null) {
      wpFeaturedmedia = new List<Replies>();
      json['wp:featuredmedia'].forEach((v) {
        wpFeaturedmedia.add(new Replies.fromJson(v));
      });
    }
    if (json['wp:attachment'] != null) {
      wpAttachment = new List<Self>();
      json['wp:attachment'].forEach((v) {
        wpAttachment.add(new Self.fromJson(v));
      });
    }
    if (json['wp:term'] != null) {
      wpTerm = new List<WpTerm>();
      json['wp:term'].forEach((v) {
        wpTerm.add(new WpTerm.fromJson(v));
      });
    }
    if (json['curies'] != null) {
      curies = new List<Curies>();
      json['curies'].forEach((v) {
        curies.add(new Curies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection.map((v) => v.toJson()).toList();
    }
    if (this.about != null) {
      data['about'] = this.about.map((v) => v.toJson()).toList();
    }
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    if (this.wpFeaturedmedia != null) {
      data['wp:featuredmedia'] =
          this.wpFeaturedmedia.map((v) => v.toJson()).toList();
    }
    if (this.wpAttachment != null) {
      data['wp:attachment'] = this.wpAttachment.map((v) => v.toJson()).toList();
    }
    if (this.wpTerm != null) {
      data['wp:term'] = this.wpTerm.map((v) => v.toJson()).toList();
    }
    if (this.curies != null) {
      data['curies'] = this.curies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Replies {
  bool embeddable;
  String href;

  Replies({this.embeddable, this.href});

  Replies.fromJson(Map<String, dynamic> json) {
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class WpTerm {
  String taxonomy;
  bool embeddable;
  String href;

  WpTerm({this.taxonomy, this.embeddable, this.href});

  WpTerm.fromJson(Map<String, dynamic> json) {
    taxonomy = json['taxonomy'];
    embeddable = json['embeddable'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxonomy'] = this.taxonomy;
    data['embeddable'] = this.embeddable;
    data['href'] = this.href;
    return data;
  }
}

class Curies {
  String name;
  String href;
  bool templated;

  Curies({this.name, this.href, this.templated});

  Curies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    href = json['href'];
    templated = json['templated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['href'] = this.href;
    data['templated'] = this.templated;
    return data;
  }
}
