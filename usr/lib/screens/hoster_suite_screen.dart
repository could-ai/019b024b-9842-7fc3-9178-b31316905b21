import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/hoster_provider.dart';

class HosterSuiteScreen extends StatelessWidget {
  const HosterSuiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoster Suite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Your Tools',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddToolDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Tool'),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => context.read<HosterProvider>().monitorTools(),
                  icon: const Icon(Icons.monitor),
                  label: const Text('Monitor'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<HosterProvider>(
                builder: (context, hosterProvider, child) {
                  return ListView.builder(
                    itemCount: hosterProvider.hostedTools.length,
                    itemBuilder: (context, index) {
                      final tool = hosterProvider.hostedTools[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: _getToolIcon(tool['type']),
                          title: Text(tool['name']),
                          subtitle: Text('Type: ${tool['type']} | Status: ${tool['status']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => hosterProvider.removeTool(tool['id']),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getToolIcon(String type) {
    switch (type) {
      case 'API Server':
        return const Icon(Icons.api, color: Colors.blue);
      case 'Database':
        return const Icon(Icons.storage, color: Colors.green);
      case 'Webhook':
        return const Icon(Icons.webhook, color: Colors.orange);
      case 'Container':
        return const Icon(Icons.widgets, color: Colors.purple);
      default:
        return const Icon(Icons.settings);
    }
  }

  void _showAddToolDialog(BuildContext context) {
    final nameController = TextEditingController();
    String selectedType = 'API Server';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Tool'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tool Name'),
            ),
            const SizedBox(height: 16),
            Consumer<HosterProvider>(
              builder: (context, hosterProvider, child) {
                return DropdownButtonFormField<String>(
                  value: selectedType,
                  items: hosterProvider.toolTypes
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) => selectedType = value!,
                  decoration: const InputDecoration(labelText: 'Tool Type'),
                );
              },
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
                  context.read<HosterProvider>().addTool({
                    'id': DateTime.now().toString(),
                    'name': nameController.text,
                    'type': selectedType,
                    'status': 'starting',
                  });
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