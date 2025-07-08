import 'package:flutter/material.dart';
import '../../models/tag.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Tag tag;
  final VoidCallback onConfirm;

  const ConfirmDeleteDialog({
    Key? key,
    required this.tag,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar Exclusão'),
      content: Text('Deseja realmente excluir a tag "${tag.tagName}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text('Excluir'),
        ),
      ],
    );
  }
}