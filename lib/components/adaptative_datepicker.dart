import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  _showDatePicker(BuildContext context) async {
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
        onDateChange(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : SizedBox(
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        // : _selectedDate.toString(),
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showDatePicker(context);
                  },
                  child: Text(
                    'Selecione outra data',
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
  }
}
