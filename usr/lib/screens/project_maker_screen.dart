import 'package:flutter/material.dart';

class ProjectMakerScreen extends StatelessWidget {
  const ProjectMakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Maker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visual Workflow Builder',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildToolbox(context),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Canvas Area - Drag blocks here to build workflows'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildWorkflowControls(context),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbox(BuildContext context) {
    final blockTypes = [
      {'name': 'API Call', 'icon': Icons.api, 'color': Colors.blue},
      {'name': 'Database Query', 'icon': Icons.storage, 'color': Colors.green},
      {'name': 'AI Process', 'icon': Icons.psychology, 'color': Colors.purple},
      {'name': 'Condition', 'icon': Icons.call_split, 'color': Colors.orange},
      {'name': 'Loop', 'icon': Icons.loop, 'color': Colors.red},
      {'name': 'Data Transform', 'icon': Icons.transform, 'color': Colors.teal},
      {'name': 'Webhook', 'icon': Icons.webhook, 'color': Colors.indigo},
      {'name': 'Timer', 'icon': Icons.timer, 'color': Colors.brown},
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Block Toolbox',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: blockTypes.map((block) {
                return Draggable<String>(
                  data: block['name'] as String,
                  feedback: Material(
                    child: Chip(
                      avatar: Icon(block['icon'] as IconData, color: block['color'] as Color),
                      label: Text(block['name'] as String),
                      backgroundColor: (block['color'] as Color).withOpacity(0.2),
                    ),
                  ),
                  child: Chip(
                    avatar: Icon(block['icon'] as IconData, color: block['color'] as Color),
                    label: Text(block['name'] as String),
                    backgroundColor: (block['color'] as Color).withOpacity(0.1),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkflowControls(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Save workflow
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Run workflow
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Run'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Export workflow
              },
              icon: const Icon(Icons.download),
              label: const Text('Export'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Create subworkflow
              },
              icon: const Icon(Icons.call_merge),
              label: const Text('Subflow'),
            ),
          ],
        ),
      ),
    );
  }
}