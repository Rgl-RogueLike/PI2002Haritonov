import 'dart:io';

class Machine {
  int _coffeBeans;
  int _milk;
  int _water;
  int _cash;

  Machine(this._coffeBeans, this._milk, this._water, this._cash);

  void readComand() {
    printComands();
    String? comand = stdin.readLineSync()?.toLowerCase();
    while ((comand != 'exit' && comand != 'manipulating')) {
      print('Введите правильный код');
      comand = stdin.readLineSync()?.toLowerCase();
    }
    if (comand == 'exit') {
      return;
    } else if (comand == 'manipulating') {
      print('Доступные команды: "Сварить кофе", "Добавить ресурс"');
      comand = stdin.readLineSync()?.toLowerCase();
      while (comand != 'add res' && comand != 'make coffee') {
        print('Ввдите правильный код');
        comand = stdin.readLineSync()?.toLowerCase();
      }
      if (comand == 'add res') {
        String? res = '';
        int q = -1;
        while (res != 'milk' &&
            res != 'coffee' &&
            res != 'water' &&
            res != 'cash') {
          print('Выберите какой ресурс добавить (молоко, вода, кофе, наличные)');
          res = (stdin.readLineSync())?.toLowerCase();
        }
        while (q < 0) {
          print('Введите количество ресурсов');
          q = int.parse(stdin.readLineSync()!);
        }
        switch (res) {
          case 'milk':
            _milk += q;
            print(map);
            readComand();
            break;
          case 'coffee':
            _coffeBeans += q;
            print(map);
            readComand();
            break;
          case 'water':
            _water += q;
            print(map);
            readComand();
            break;
          case 'cash':
            _cash += q;
            print(map);
            readComand();
            break;
        }
      }
      if (comand == 'make coffee') {
        makingCofee();
      }
    }
  }

  set milk(int num) {
    if (num >= 0) {
      _milk = num;
    }
  }

  set coffe(int num) {
    if (num >= 0) {
      _coffeBeans = num;
    }
  }

  set water(int num) {
    if (num >= 0) {
      _water = num;
    }
  }

  set cash(int num) {
    if (num >= 0) {
      _cash = num;
    }
  }

  bool isAvailableRes() {
    if (_coffeBeans >= 50 && _water >= 100) {
      return true;
    }
    return false;
  }

  void makingCofee() {
    if (isAvailableRes()) {
      print('Ваш кофе готовится \n');
      subatractRes();
      print(map);
      readComand();
    } else {
      print(
          'Для этой операции требуется: Кофе в зернах-50г, вода-100мл.\nУ нас есть ${_coffeBeans}г кофее и ${_water}мл воды');
      readComand();
    }
  }

  void subatractRes() {
    _coffeBeans -= 50;
    _water -= 100;
  }

  Map<String, dynamic> get map {
    return {
      "coffee": _coffeBeans,
      "milk": _milk,
      "water": _water,
      "cash": _cash,
    };
  }

  void printComands() {
    print('Доступные команды: "Редактирование", "Выход"');
  }
}
