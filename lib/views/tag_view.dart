import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tag_controller.dart';
import '../models/tag.dart';
import 'widgets/tag_list_item.dart';
import 'widgets/add_tag_dialog.dart';
import 'widgets/edit_tag_dialog.dart';
import 'widgets/confirm_delete_dialog.dart';

class TagView extends StatefulWidget {
  @override
  _TagViewState createState() => _TagViewState();
}

class _TagViewState extends State<TagView> {
  @override
  void initState() {
    super.initState();
    // Carregar dados ao iniciar a aplicação
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TagController>().loadTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags WordPress'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<TagController>().loadTags(),
          ),
        ],
      ),
      body: Consumer<TagController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty) {
            return _buildErrorWidget(controller);
          }

          if (controller.tags.isEmpty) {
            return _buildEmptyWidget();
          }

          return _buildTagsList(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildErrorWidget(TagController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Erro: ${controller.errorMessage}',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              controller.clearError();
              controller.loadTags();
            },
            child: Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.label_outline, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Nenhuma tag encontrada',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsList(TagController controller) {
    return ListView.builder(
      itemCount: controller.tags.length,
      itemBuilder: (context, index) {
        final tag = controller.tags[index];
        return TagListItem(
          tag: tag,
          onEdit: () => _showEditDialog(tag),
          onDelete: () => _showDeleteDialog(tag),
        );
      },
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTagDialog(
        onAdd: (name, tagIcon, tagColor) {
          context.read<TagController>().addTag(name, tagIcon, tagColor);
        },
      ),
    );
  }

  void _showEditDialog(Tag tag) {
    showDialog(
      context: context,
      builder: (context) => EditTagDialog(
        tag: tag,
        onUpdate: (updatedTag) {
          context.read<TagController>().updateTag(updatedTag);
        },
      ),
    );
  }

  void _showDeleteDialog(Tag tag) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDeleteDialog(
        tag: tag,
        onConfirm: () {
          context.read<TagController>().deleteTag(tag.id);
        },
      ),
    );
  }
}
