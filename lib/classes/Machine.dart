import 'Enums.dart';
import 'Methods.dart';

class Resources {
  late double _coffeeBeans;
  late double _milk;
  late double _water;
  late double _cash;
  double usercash = 0;
  Resources({
    required double coffeeBeans,
    required double milk,
    required double water,
    required double cash,
  })  : _coffeeBeans = coffeeBeans,
        _milk = milk,
        _water = water,
        _cash = cash;

  //Resources.withCash(double cash) : _cash = cash;

  Resources getResources() {
    return Resources(
      coffeeBeans: _coffeeBeans,
      milk: _milk,
      water: _water,
      cash: _cash,
    );
  }

  void setResources(Resources value) {
    _coffeeBeans = value._coffeeBeans;
    _milk = value._milk;
    _water = value._water;
    _cash = value._cash;
  }

  set cash(double value) {
    _cash = value;
  }

  void addCash(double value) {
    _cash += value;
  }

  void returnCash() {
    _cash = 0;
  }

  void addRes(double value1, double value2, double value3, double value4) {
    _milk += value1;
    _water += value2;
    _coffeeBeans += value3;
    usercash += value4;
  }

  void removeRes(double value1, double value2, double value3, double value4) {
    _milk -= value1;
    _water -= value2;
    _coffeeBeans -= value3;
    usercash -= value4;
  }
}

abstract class ICoffee {
  double coffeeBeans();
  double milk();
  double water();
  double cash();
}

class Espresso extends ICoffee {
  @override
  double coffeeBeans() {
    return 50;
  }

  @override
  double milk() {
    return 0;
  }

  @override
  double water() {
    return 100;
  }

  @override
  double cash() {
    return 1.5;
  }
}

class Americano extends ICoffee {
  @override
  double coffeeBeans() {
    return 50;
  }

  @override
  double milk() {
    return 0;
  }

  @override
  double water() {
    return 200;
  }

  @override
  double cash() {
    return 2.0;
  }
}

class Cappuccino extends ICoffee {
  @override
  double coffeeBeans() {
    return 50;
  }

  @override
  double milk() {
    return 100;
  }

  @override
  double water() {
    return 100;
  }

  @override
  double cash() {
    return 2.5;
  }
}

class Latte extends ICoffee {
  @override
  double coffeeBeans() {
    return 50;
  }

  @override
  double milk() {
    return 250;
  }

  @override
  double water() {
    return 100;
  }

  @override
  double cash() {
    return 3.0;
  }
}

class Machine {
  Resources _resources;

  Machine(this._resources) {
    this._resources._coffeeBeans = coffeeBeans;
    this._resources._milk = milk;
    this._resources._water = water;
    this._resources._cash = cash;
  }

  void fillResources() {
    _resources.setResources(Resources(
      coffeeBeans: _resources._coffeeBeans,
      milk: _resources._milk,
      water: _resources._water,
      cash: _resources._cash,
    ));
  }

  void fillCash(double amount) {
    _resources.addCash(amount);
  }

  void addAllRes(
      double amount1, double amount2, double amount3, double amount4) {
    _resources.addRes(amount1, amount2, amount3, amount4);
  }

  void RemoveAllRes(
      double amount1, double amount2, double amount3, double amount4) {
    _resources.removeRes(amount1, amount2, amount3, amount4);
  }

  void returnAllCash() {
    _resources.returnCash();
  }

  double get coffeeBeans => _resources._coffeeBeans;

  double get milk => _resources._milk;

  double get water => _resources._water;

  double get cash => _resources._cash;

  double get usercash => _resources.usercash;

  bool isAvailableResources(ICoffee coffeeType) {
    return _resources._coffeeBeans >= coffeeType.coffeeBeans() &&
        _resources._milk >= coffeeType.milk() &&
        _resources._water >= coffeeType.water() &&
        _resources._cash >= coffeeType.cash();
  }

  Future<List<String>> makeCoffeeByType(CoffeeType coffeeType) async {
    MessageHandler messageHandler = MessageHandler();
    messageHandler.clearMessages();
    ICoffee coffee;

    switch (coffeeType) {
      case CoffeeType.espresso:
        coffee = Espresso();
        break;
      case CoffeeType.americano:
        coffee = Americano();
        break;
      case CoffeeType.cappuccino:
        coffee = Cappuccino();
        break;
      case CoffeeType.latte:
        coffee = Latte();
        break;
    }

    if (isAvailableResources(coffee)) {
      _resources._coffeeBeans -= coffee.coffeeBeans();
      _resources._milk -= coffee.milk();
      _resources._water -= coffee.water();
      _resources._cash -= coffee.cash();
      _resources.usercash += coffee.cash();

      messageHandler.addMessage('*————*');
      messageHandler.addMessage('_start_');

      await heatWater();
      messageHandler.addMessage('_then_');
      await brewCoffee();
      if (coffeeType == CoffeeType.cappuccino ||
          coffeeType == CoffeeType.latte) {
        await frothMilk();
        await mixCoffeeAndMilk();
      }
      messageHandler.addMessage(
          'Your ${coffeeType.toString().split('.').last} is ready!');
    } else {
      messageHandler.addMessage(
          'Not enough resources to make ${coffeeType.toString().split('.').last}');
    }

    return messageHandler.getMessages();
  }
}

void main() {
  Machine mach =
      new Machine(Resources(coffeeBeans: 100, milk: 100, water: 100, cash: 0));
}
