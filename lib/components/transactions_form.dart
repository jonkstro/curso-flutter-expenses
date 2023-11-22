// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  /// Aqui é pra dizer que vamos precisar de uma função no construtor, essa função
  /// será passada pelo componente pai e será executada ao apertar o botão enviar
  /// esse método se chama de comunicação indireta, onde passa a função como parametro
  final void Function(String, double, DateTime) onSubmit;

  /// A função onsubmit tá recebendo um add transactions.
  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _valueController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    // Vai tentar parsear o valor, se não conseguir vai meter 0
    final value = double.tryParse(_valueController.text) ?? 0.0;
    // Vai fazer a função de adicionar transação do transaction_user
    if (title.isEmpty || value <= 0) {
      return;
    } else {
      widget.onSubmit(title, value, _selectedDate);
    }
  }

  _showDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      // Define a localização para português do Brasil
      locale: Locale('pt', 'BR'),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        /// DADO ALTERADO = INTERFACE DEVERÁ REFLETIR
        /// Componente é STATEFULL
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        // elevation: 5,

        child: Padding(
          padding: EdgeInsets.fromLTRB(
              10, 10, 10, 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _titleController,

                  /// Aqui é pra fazer o submit quando apertar o enter no teclado
                  /// o '_' é porque ele pede um parametro, mas não precisamos
                  /// por isso usamos essa gambiearra
                  onSubmitted: (_) {
                    _submitForm();
                  },
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _valueController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),

                  /// Aqui é pra fazer o submit quando apertar o enter no teclado
                  /// o '_' é porque ele pede um parametro, mas não precisamos
                  /// por isso usamos essa gambiearra
                  onSubmitted: (_) {
                    _submitForm();
                  },
                  decoration: InputDecoration(
                    labelText: 'Valor (R\$)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada!'
                            // : _selectedDate.toString(),
                            : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showDatePicker();
                      },
                      child: Text(
                        'Selecione outra data',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _submitForm();
                  },
                  icon: Icon(Icons.add),
                  label: Text('Nova Transação'),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      minimumSize: Size(200, 50)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
