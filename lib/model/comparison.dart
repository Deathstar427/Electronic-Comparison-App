// ignore: camel_case_types
class Comparison_Items {
  // ignore: non_constant_identifier_names
  String _Title;
  // ignore: non_constant_identifier_names
  String _RearCamera;
  String _FrontCamera;
  String _display;
  String _Color;
  String _Resolution;
  String _Dimensions;
  String _weight;
  String _Battery;
  String _WirelessComm;
  String _Model;
  String _Accessories;
  String _Ratings;
  String _MRP;
  String _Price;
  String _Discount;
  String _Review;

  Comparison_Items(
      this._Title,
      this._RearCamera,
      this._FrontCamera,
      this._display,
      this._Color,
      this._Resolution,
      this._Dimensions,
      this._weight,
      this._Battery,
      this._WirelessComm,
      this._Model,
      this._Accessories,
      this._Ratings,
      this._MRP,
      this._Price,
      this._Discount,
      this._Review);

  String get Title => _Title;
  String get RearCamera => _RearCamera;
  String get FrontCamera => _FrontCamera;
  String get display => _display;
  String get Color => _Color;
  String get Resolution => _Resolution;
  String get Dimensions => _Dimensions;
  String get weight => _weight;
  String get Battery => _Battery;
  String get WirelessComm => _WirelessComm;
  String get Model => _Model;
  String get Accessories => _Accessories;
  String get Ratings => _Ratings;
  String get MRP => _MRP;
  String get Price => _Price;
  String get Discount => _Discount;
  String get Review => _Review;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["Title"] = _Title;
    map["RearCamera"] = _RearCamera;
    map["FrontCamera"] = _FrontCamera;
    map["display"] = _display;
    map["Color"] = _Color;
    map["Resolution"] = _Resolution;
    map["Dimensions"] = _Dimensions;
    map["weight"] = _weight;
    map["Battery"] = _Battery;
    map["WirelessComm"] = _WirelessComm;
    map["Model"] = _Model;
    map["Accessories"] = _Accessories;
    map["Ratings"] = _Ratings;
    map["MRP"] = _MRP;
    map["Price"] = _Price;
    map["Discount"] = _Discount;
    map["Review"] = _Review;

    return map;
  }

  Comparison_Items.fromObject(dynamic o) {
    this._Title = o["Title"];
    this._RearCamera = o["RearCamera"];
    this._FrontCamera = o["FrontCamera"];
    this._display = o["display"];
    this._Color = o["Color"];
    this._Resolution = o["Resolution"];
    this._Dimensions = o["Dimensions"];
    this._weight = o["weight"];
    this._Battery = o["Battery"];
    this._WirelessComm = o["WirelessComm"];
    this._Model = o["Model"];
    this._Accessories = o["Accessories"];
    this._Ratings = o["Ratings"];
    this._MRP = o["MRP"];
    this._Price = o["Price"];
    this._Discount = o["Discount"];
    this._Review = o["Review"];
  }
}
