import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/vibe_provider.dart';

class VibePlannerScreen extends StatelessWidget {
  const VibePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vibe Planner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI-Powered Workflow Planning',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildModelSelector(context),
            const SizedBox(height: 20),
            _buildBackgroundInfoSection(context),
            const SizedBox(height: 20),
            _buildCharacterPresets(context),
            const SizedBox(height: 20),
            Expanded(
              child: _buildWorkflowsList(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateWorkflowDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildModelSelector(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Model Selection',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Consumer<VibeProvider>(
              builder: (context, vibeProvider, child) {
                return DropdownButton<String>(
                  value: vibeProvider.selectedModel,
                  items: vibeProvider.availableModels
                      .map((model) => DropdownMenuItem(
                            value: model,
                            child: Text(model),
                          ))
                      .toList(),
                  onChanged: (value) => vibeProvider.setSelectedModel(value!),
                  isExpanded: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Background Knowledge',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddBackgroundInfoDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Consumer<VibeProvider>(
              builder: (context, vibeProvider, child) {
                return Wrap(
                  spacing: 8,
                  children: vibeProvider.backgroundInfo
                      .map((info) => Chip(
                            label: Text(info.length > 20 ? '${info.substring(0, 20)}...' : info),
                            onDeleted: () => vibeProvider.removeBackgroundInfo(
                              vibeProvider.backgroundInfo.indexOf(info),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterPresets(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Character Presets',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Consumer<VibeProvider>(
              builder: (context, vibeProvider, child) {
                return Wrap(
                  spacing: 8,
                  children: vibeProvider.characterPresets
                      .map((preset) => Chip(
                            label: Text(preset['name']),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkflowsList(BuildContext context) {
    return Consumer<VibeProvider>(
      builder: (context, vibeProvider, child) {
        return ListView.builder(
          itemCount: vibeProvider.workflows.length,
          itemBuilder: (context, index) {
            final workflow = vibeProvider.workflows[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(workflow['name'] ?? 'Unnamed Workflow'),
                subtitle: Text(workflow['description'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => vibeProvider.removeWorkflow(workflow['id']),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCreateWorkflowDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Workflow'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Workflow Name'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                context.read<VibeProvider>().addWorkflow({
                  'id': DateTime.now().toString(),
                  'name': nameController.text,
                  'description': descController.text,
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showAddBackgroundInfoDialog(BuildContext context) {
    final infoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Background Information'),
        content: TextField(
          controller: infoController,
          decoration: const InputDecoration(labelText: 'Background Info'),
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
            TextButton(
              onPressed: () {
                if (infoController.text.isNotEmpty) {
                  context.read<VibeProvider>().addBackgroundInfo(infoController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
        ],
      ),
    );
  }
}