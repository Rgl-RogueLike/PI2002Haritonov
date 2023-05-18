class MessageHandler {
  static final MessageHandler _instance = MessageHandler._internal();
  List<String> _messages = [];

  factory MessageHandler() {
    return _instance;
  }

  MessageHandler._internal();

  void addMessage(String message) {
    _messages.add(message);
  }

  List<String> getMessages() {
    return List<String>.from(_messages);
  }

  void clearMessages() {
    _messages.clear();
  }
}

//метод для нагрева воды с задержкой в 3 секунды
Future<void> heatWater() async {
  MessageHandler messageHandler = MessageHandler();
  messageHandler.addMessage('start_process: water');
  await Future.delayed(Duration(seconds: 1));
  messageHandler.addMessage('done_process: water');
}

//метод заваривания кофе (после нагрева воды) с задержкой в 5 секунд
Future<void> brewCoffee() async {
  MessageHandler messageHandler = MessageHandler();
  messageHandler.addMessage('start_process: coffee with water');
  await Future.delayed(Duration(seconds: 1));
  messageHandler.addMessage('done_process: coffee with water');
}

//метод для взбивания молока (запускается вместе с завариванием кофе) с
//задержкой в 5 секунд
Future<void> frothMilk() async {
  MessageHandler messageHandler = MessageHandler();
  messageHandler.addMessage('start_process: milk');
  await Future.delayed(Duration(seconds: 1));
  messageHandler.addMessage('done_process: milk');
}

//метод для смешивания кофе и молока
//(запускается после приготовления кофе и молока) с задержкой в 3 секунды
Future<void> mixCoffeeAndMilk() async {
  MessageHandler messageHandler = MessageHandler();
  messageHandler.addMessage('start_process: mix coffee and milk');
  await Future.delayed(Duration(seconds: 1));
  messageHandler.addMessage('done_process: mix coffee and milk');
}
