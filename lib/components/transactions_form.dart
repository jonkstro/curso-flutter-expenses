// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_null_comparison
import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_datepicker.dart';
import 'package:expenses/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';

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

  _submitForm() {
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
                child: AdaptativeTextField(
                  label: 'Título',
                  controller: _titleController,

                  /// Aqui é pra fazer o submit quando apertar o enter no teclado
                  /// o '_' é porque ele pede um parametro, mas não precisamos
                  /// por isso usamos essa gambiearra
                  onSubmitted: (_) {
                    _submitForm();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdaptativeTextField(
                  controller: _valueController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),

                  /// Aqui é pra fazer o submit quando apertar o enter no teclado
                  /// o '_' é porque ele pede um parametro, mas não precisamos
                  /// por isso usamos essa gambiearra
                  onSubmitted: (_) {
                    _submitForm();
                  },
                  label: 'Valor (R\$)',
                ),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.all(10),
                // child: ElevatedButton.icon(
                //   onPressed: () {
                //     _submitForm();
                //   },
                //   icon: Icon(Icons.add),
                //   label: Text('Nova Transação'),
                //   style: ElevatedButton.styleFrom(
                //       elevation: 5,
                //       backgroundColor: Colors.purple,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(50),
                //       ),
                //       minimumSize: Size(200, 50)),
                // ),
                child: AdaptativeButton(
                    label: "Nova Transação",
                    onPressed: () {
                      _submitForm();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
