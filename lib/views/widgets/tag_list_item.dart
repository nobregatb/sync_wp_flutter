import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/tag.dart';

class TagListItem extends StatelessWidget {
  final Tag tag;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TagListItem({
    Key? key,
    required this.tag,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: FaIcon(
            _getIconFromString(tag.tagIcon),
            color: _getColorFromHex(tag.tagColor),
            size: 24,
          ),
        ),
        title: Text(tag.tagName),
        subtitle: Text('Posts: ${tag.count}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconFromString(String iconString) {
    // Mapeamento de strings para ícones do Font Awesome
    final iconMap = {
      'fas fa-tag': FontAwesomeIcons.tag,
      'fas fa-star': FontAwesomeIcons.star,
      'fas fa-heart': FontAwesomeIcons.heart,
      'fas fa-home': FontAwesomeIcons.house,
      'fas fa-user': FontAwesomeIcons.user,
      'fas fa-book': FontAwesomeIcons.book,
      'fas fa-camera': FontAwesomeIcons.camera,
      'fas fa-music': FontAwesomeIcons.music,
      'fas fa-car': FontAwesomeIcons.car,
      'fas fa-plane': FontAwesomeIcons.plane,
      'fas fa-coffee': FontAwesomeIcons.coffee,
      'fas fa-gamepad': FontAwesomeIcons.gamepad,
      'fas fa-laptop': FontAwesomeIcons.laptop,
      'fas fa-mobile': FontAwesomeIcons.mobile,
      'fas fa-shopping-cart': FontAwesomeIcons.shoppingCart,
      'fas fa-gift': FontAwesomeIcons.gift,
      'fas fa-lightbulb': FontAwesomeIcons.lightbulb,
      'fas fa-clock': FontAwesomeIcons.clock,
      'fas fa-calendar': FontAwesomeIcons.calendar,
      'fas fa-map': FontAwesomeIcons.map,
    };
    
    return iconMap[iconString] ?? FontAwesomeIcons.tag;
  }

  Color _getColorFromHex(String hexColor) {
    try {
      // Remove o # se estiver presente
      String colorString = hexColor.replaceAll('#', '');
      
      // Adiciona FF para opacidade se necessário
      if (colorString.length == 6) {
        colorString = 'FF' + colorString;
      }
      
      return Color(int.parse(colorString, radix: 16));
    } catch (e) {
      return Colors.black; // Cor padrão em caso de erro
    }
  }
}