import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/cart_model.dart';
import 'package:shopping_cart/db_helper.dart';

class Cartprovider with ChangeNotifier{

  DBHelper db = DBHelper();
  int _counter =0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double  get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart=> _cart;

   Future<List<Cart>> getData() async{
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItess()async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();

  }
  void _getPrefItess()async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    _counter= prefs.getInt('cart_item') ?? 0;
    _totalPrice= prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter(){
    _counter++;
    _setPrefItess();
    notifyListeners();
  }
  void removerCounter(){
    _counter--;
    _setPrefItess();
    notifyListeners();
  }

  int getCounter(){
    _getPrefItess();
    return _counter;
  }

  void addTotalPrice(double productPrice){
    _totalPrice = _totalPrice + productPrice;
    _setPrefItess();
    notifyListeners();
  }
  void removerTotalPrice(double productPrice){
    _totalPrice = _totalPrice - productPrice;
    _setPrefItess();
    notifyListeners();
  }

  double getTotalPrice(){
    _getPrefItess();
    return _totalPrice;
  }



}