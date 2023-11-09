// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  /// Aqui é pra dizer que vamos precisar de uma função no construtor, essa função
  /// será passada pelo componente pai e será executada ao apertar o botão enviar
  /// esse método se chama de comunicação indireta, onde passa a função como parametro
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final valueController = TextEditingController();

  final titleController = TextEditingController();

  void _submitForm() {
    final title = titleController.text;
    // Vai tentar parsear o valor, se não conseguir vai meter 0
    final value = double.tryParse(valueController.text) ?? 0.0;
    // Vai fazer a função de adicionar transação do transaction_user
    if (title.isEmpty || value <= 0) {
      return;
    } else {
      widget.onSubmit(title, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,

                /// Aqui é pra fazer o submit quando apertar o enter no teclado
                /// o '_' é porque ele pede um parametro, mas não precisamos
                /// por isso usamos essa gambiearra
                onSubmitted: (_) {
                  _submitForm();
                },
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: valueController,
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
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton.icon(
                onPressed: () {
                  _submitForm();
                },
                icon: Icon(Icons.add),
                label: Text('Criar Transação'),
                style: ElevatedButton.styleFrom(
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
    );
  }
}
