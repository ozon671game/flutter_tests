// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tests/main.dart';

import 'rocket.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoList());
    await tester.enterText(find.byType(TextField), 'text');
    await tester.tap(find.byIcon(Icons.add));
    tester.pump();

  });

  test('where method Square class work', (){
    var s = Square(15);
    var a = s.getPlaceSize();
    expect(a, 225);
  });

  group('Rocket', (){
    test('class Rocket test', (){
      var rocket = Rocket.basic();
      expect(rocket.shouldFuel, 20);

      rocket.fill(5);
      expect(rocket.shouldFuel, 15);
    });
    test('work with Mocktail', (){
      var rocket = MockRocket.basic();
      rocket.fill(5);
      expect(rocket.countFuel, 35);
      expect(rocket.shouldFuel, 15);

      when(()=> rocket.start()).thenReturn('good');
      expect(rocket.start(), 'good');
    });
  });

}

class MockRocket extends Rocket implements Mock{
  MockRocket(l, c) : super(l, c);
  MockRocket.basic() : super.basic();
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    background: Container(color: Colors.red),
                    child: ListTile(title: Text(todo)),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Square {
 final double size;

  Square(this.size);
  double getPlaceSize() {
    return size * size;
  }
}
