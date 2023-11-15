// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:flutter/material.dart';

import 'package:expenses/components/transactions_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transaction.dart';

void main(List<String> args) {
  runApp(const ExpenssesApp());
}

class ExpenssesApp extends StatelessWidget {
  const ExpenssesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // VARIAVEL QUE VAI SERVIR PRA DEFINIR OS TEMAS DE CORES
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: MyHomePage(),
      // DEFINIR OS TEMAS DO APLICATIVO:
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headlineMedium: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Aqui vamos criar alguns objetos pra adicionar depois
  // ignore: unused_field
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Conta antiga',
      value: 400.76,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de água',
      value: 200,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
  ];

  // Pegar as transações somente da semana - ultimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      // Se a transação for recente é verdadeiro a função
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // MÉTODO QUE VAI ADICIONAR AS TRANSAÇÕES
  void _addTransactions(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.timestamp(),
    );

    /// ALTERAR O ESTADO DA LISTA. POR ISSO PRECISAMOS USAR UM STATEFULL WIDGET
    setState(() {
      _transactions.add(newTransaction);
    });

    // FECHANDO O MODAL APÓS SALVAR NA LISTA:
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransactions);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        centerTitle: true,
        // NÃO PRECISA MAIS POIS TÁ NO THEME NO primarySwatch
        // backgroundColor: Color.fromARGB(255, 89, 4, 104),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _openTransactionFormModal(context);
            },
            icon: Icon(
              Icons.add_circle_outline,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Chama o CHART passando as transações recentes
            Chart(recentTransactions: _recentTransactions),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // NÃO PRECISA MAIS POIS TÁ NO THEME NO primarySwatch
        // backgroundColor: Colors.purple,
        child: Icon(Icons.add),
        onPressed: () {
          _openTransactionFormModal(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}




/**
 * 
 * E outra coisa, será necessária uma mudança quando for utilizar as cores colocadas no tema. Na próxima aula, por exemplo, lá no arquivo “transaction_list.dart” em um trecho do códigos nós temos:

color: Theme.of(context).primaryColor,
Agora será assim:

color: Theme.of(context).colorScheme.primary,
Basicamente é isso galera. Bons estudos!
 * 
 * 
 * 
import 'package:flutter/material.dart';
import 'dart:math';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'models/transaction.dart';
 
main() => runApp(ExpensesApp());
 
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
 
    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];
 
  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
 
    setState(() {
      _transactions.add(newTransaction);
    });
 
    Navigator.of(context).pop();
  }
 
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
 */