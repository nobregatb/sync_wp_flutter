import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/tag.dart';

class EditTagDialog extends StatefulWidget {
  final Tag tag;
  final Function(Tag tag) onUpdate;

  const EditTagDialog({Key? key, required this.tag, required this.onUpdate}) : super(key: key);

  @override
  _EditTagDialogState createState() => _EditTagDialogState();
}

class _EditTagDialogState extends State<EditTagDialog> {
  late TextEditingController _nameController;
  late String _selectedIcon;
  late String _selectedColor;

  final List<Map<String, dynamic>> _iconOptions = [
    {'name': 'Tag', 'value': 'fas fa-tag', 'icon': FontAwesomeIcons.tag},
    {'name': 'Estrela', 'value': 'fas fa-star', 'icon': FontAwesomeIcons.star},
    {'name': 'Coração', 'value': 'fas fa-heart', 'icon': FontAwesomeIcons.heart},
    {'name': 'Casa', 'value': 'fas fa-home', 'icon': FontAwesomeIcons.house},
    {'name': 'Usuário', 'value': 'fas fa-user', 'icon': FontAwesomeIcons.user},
    {'name': 'Livro', 'value': 'fas fa-book', 'icon': FontAwesomeIcons.book},
    {'name': 'Câmera', 'value': 'fas fa-camera', 'icon': FontAwesomeIcons.camera},
    {'name': 'Música', 'value': 'fas fa-music', 'icon': FontAwesomeIcons.music},
    {'name': 'Carro', 'value': 'fas fa-car', 'icon': FontAwesomeIcons.car},
    {'name': 'Avião', 'value': 'fas fa-plane', 'icon': FontAwesomeIcons.plane},
    {'name': 'Café', 'value': 'fas fa-coffee', 'icon': FontAwesomeIcons.coffee},
    {'name': 'Gamepad', 'value': 'fas fa-gamepad', 'icon': FontAwesomeIcons.gamepad},
  ];

  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'Preto', 'value': '#000000'},
    {'name': 'Azul', 'value': '#2196F3'},
    {'name': 'Vermelho', 'value': '#F44336'},
    {'name': 'Verde', 'value': '#4CAF50'},
    {'name': 'Laranja', 'value': '#FF9800'},
    {'name': 'Roxo', 'value': '#9C27B0'},
    {'name': 'Rosa', 'value': '#E91E63'},
    {'name': 'Ciano', 'value': '#00BCD4'},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag.tagName);
    _selectedIcon = widget.tag.tagIcon;
    _selectedColor = widget.tag.tagColor;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Tag'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome da Tag'),
            ),
            SizedBox(height: 16),
            Text('Ícone:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _iconOptions.map((iconOption) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(iconOption['icon'], size: 16),
                      SizedBox(width: 4),
                      Text(iconOption['name']),
                    ],
                  ),
                  selected: _selectedIcon == iconOption['value'],
                  onSelected: (selected) {
                    setState(() {
                      _selectedIcon = iconOption['value'];
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Cor:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _colorOptions.map((colorOption) {
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: _getColorFromHex(colorOption['value']),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(colorOption['name']),
                    ],
                  ),
                  selected: _selectedColor == colorOption['value'],
                  onSelected: (selected) {
                    setState(() {
                      _selectedColor = colorOption['value'];
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              widget.tag.tagName = _nameController.text;
              widget.tag.tagIcon = _selectedIcon;
              widget.tag.tagColor = _selectedColor;
              
              widget.onUpdate(widget.tag);
              Navigator.pop(context);
            }
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }

  Color _getColorFromHex(String hexColor) {
    try {
      String colorString = hexColor.replaceAll('#', '');
      if (colorString.length == 6) {
        colorString = 'FF' + colorString;
      }
      return Color(int.parse(colorString, radix: 16));
    } catch (e) {
      return Colors.black;
    }
  }
}