abstract class Serviceable {
  void service();
}

mixin GPS {
  void nav() => print("GPS: Navigating...");
}

class Car implements Serviceable {
  String color;
  Car(this.color);

  void honk() => print("Car ($color): Beep!");
  @override
  void service() => print("Car ($color): Serviced.");

  Future<String> check() async {
    print("Car ($color): Checking diagnostics...");
    await Future.delayed(const Duration(seconds: 2));
    return "Car ($color): All OK!";
  }
}

class SportsCar extends Car {
  SportsCar(super.color);
  @override
  void honk() => print("SportsCar ($color): Vroom!");
}

class ElectricCar extends Car with GPS {
  ElectricCar(super.color);
  @override
  void honk() => print("ElectricCar ($color): Chime!");

  Future<String> charge() async {
    print("ElectricCar ($color): Charging...");
    await Future.delayed(const Duration(seconds: 2));
    return "ElectricCar ($color): Fully charged!";
  }
}

class DeliveryDrone with GPS {}

void main() async {
  final squad = [Car("Green"), SportsCar("Red"), ElectricCar("Yellow")];
  for (final car in squad) {
    car.honk();
    car.service();
  }

  print("-----------------------");
  final ev = ElectricCar("Blue");
  ev.nav();
  DeliveryDrone().nav();

  print("-----------------------");
  print("Main: Requesting charge...");
  print(await ev.charge());

  print("\nMain: Requesting diagnostics...");
  print(await squad[1].check());
}
