// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:math';
import 'dart:io';

import 'package:expenses/components/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expenses/components/transactions_form.dart';
import 'package:expenses/components/transactions_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
/**
 * Aqui é pra mudar o DATEPICKER para pt br.
 */
import 'package:flutter_localizations/flutter_localizations.dart';

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
      /**
       * Aqui é pra mudar o DATEPICKER para pt br.
       */
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ], // Adicione o locale desejado
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
            // Acessibilidade e responsividade:
            fontSize: 20 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 16 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontFamily: 'QuickSand',
            fontSize: 12 * MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'QuickSand',
              fontSize: 20 * MediaQuery.of(context).textScaleFactor,
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
  /// MÉTODO QUE FOI CRIADO SÓ PRA PODER CARREGAR NO APP AS DATAS PT_BR
  get _localeDateTime {
    // Inicialize o sistema de localização. Senão vai pegar tudo em ingles
    initializeDateFormatting('pt_BR', null);
  }

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
      title: 'ultima Conta de água',
      value: 200,
      date: DateTime.now().subtract(Duration(days: 0)),
    ),
  ];

  // Mostrar o gráfico ou não
  bool _showChart = false;

  // Pegar as transações somente da semana - ultimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      // Se a transação for recente é verdadeiro a função
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  // MÉTODO QUE VAI ADICIONAR AS TRANSAÇÕES
  _addTransactions(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    /// ALTERAR O ESTADO DA LISTA. POR ISSO PRECISAMOS USAR UM STATEFULL WIDGET
    setState(() {
      _transactions.add(newTransaction);
    });

    // FECHANDO O MODAL APÓS SALVAR NA LISTA:
    Navigator.of(context).pop();
  }

  /// Vai apagar a transação com id igual o id passado
  _removeTransactions(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return OrientationBuilder(
          builder: (context, orientation) {
            double alturaTela = mediaQuery.size.height;

            /// SE TIVER DEITADO TEM 80% DA TELA, SENÃO TEM 50%
            double pctTela = orientation == Orientation.portrait ? 0.5 : 0.8;
            return SizedBox(
              height: alturaTela * pctTela, // 80% da tela
              child: TransactionForm(_addTransactions),
            );
          },
        );
      },
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            child: Icon(icon),
            onTap: fn,
          )
        : IconButton(
            icon: Icon(icon),
            onPressed: fn,
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // AQUI EU VOU DIZER QUE MINHAS DATAS SÃO TUDO PT_BR !!!!!!!!!!!!!!!!!!!
    _localeDateTime;

    // // Vou dizer aqui que não vou deixar a aplicação rodar pro lado.
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Checar a orientação da aplicação
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, mediaQuery.size.width * .1, 0),
          child: _getIconButton(
            _showChart ? Icons.list : Icons.show_chart,
            () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, mediaQuery.size.width * .05, 0),
        child: _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () {
            _openTransactionFormModal(context);
          },
        ),
      ),
    ];

    // Configurar o appbar por fora pq tá dando problema nas alturas
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text('Despesas pessoais'),
            centerTitle: true,
            // NÃO PRECISA MAIS POIS TÁ NO THEME NO primarySwatch
            // backgroundColor: Color.fromARGB(255, 89, 4, 104),
            actions: actions,
          );

    // A altura disponível é igual a altura toda - a altura do appbar e status bar do celular
    final alturaDisponivel = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    // IOS dá problema, tem que botar safearea
    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('EXIBIR GRÁFICO'),
            //       // Switch que vai se adaptar pra android ou ios
            //       Switch.adaptive(
            //           value: _showChart,
            //           onChanged: (value) {
            //             setState(() {
            //               _showChart = value;
            //             });
            //           }),
            //     ],
            //   ),
            // Só chama se tiver no switch ou não for landscape a orientação
            if (_showChart || !isLandscape)
              // Chama o CHART passando as transações recentes
              SizedBox(
                  height: alturaDisponivel * (isLandscape ? .75 : 0.3),
                  child: Chart(
                    recentTransactions: _recentTransactions,
                  )),
            // Só chama se tiver no switch ou não for landscape a orientação
            if (!_showChart || !isLandscape)
              SizedBox(
                  height: alturaDisponivel * (isLandscape ? .9 : 0.7),
                  child: TransactionList(
                    transactions: _transactions,
                    onRemove: _removeTransactions,
                  )),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,

            /// FLOATBUTTON não existe no IOS
            /// Foi usado o dart:io para detectar o Platform e ver se é IOS ou Android
            /// Se for IOS ele tira o floatbutton
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    // NÃO PRECISA MAIS POIS TÁ NO THEME NO primarySwatch
                    // backgroundColor: Colors.purple,
                    child: Icon(Icons.add),
                    onPressed: () {
                      _openTransactionFormModal(context);
                    },
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
