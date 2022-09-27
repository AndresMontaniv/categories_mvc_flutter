import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EditDialog extends StatelessWidget {
  final String? value;
  const EditDialog({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = TextEditingController(text: value);
    return CupertinoAlertDialog(
      title: const Text('Nombre:'),
      content: Material(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(20),
        child: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 2,
              ),
            ),
            labelText: 'Nombre',
            labelStyle: const TextStyle(color: Colors.grey),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        TextButton(
          child: const Text(
            'Guardar',
          ),
          onPressed: () {
            final name = ctrl.text.trim();
            ctrl.clear();
            Navigator.pop(context, name);
          },
        ),
      ],
    );
  }
}
