import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/datapool_provider.dart';

class DatapoolManagerScreen extends StatelessWidget {
  const DatapoolManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataPool Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Global Data Pool Management',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            _buildBalancingStats(context),
            const SizedBox(height: 20),
            _buildStorageProviders(context),
            const SizedBox(height: 20),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Databases'),
                        Tab(text: 'Backups'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildDatabasesTab(context),
                          _buildBackupsTab(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAccountDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBalancingStats(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<DatapoolProvider>(
          builder: (context, datapoolProvider, child) {
            final stats = datapoolProvider.balancingStats;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Load Balancing Stats',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Total Space', '${stats['totalSpace']} GB'),
                    _buildStatItem('Used Space', '${stats['usedSpace']} GB'),
                    _buildStatItem('Files', '${stats['filesCount']}'),
                    _buildStatItem('Score', '${stats['optimizationScore']}%'),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildStorageProviders(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Storage Providers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Consumer<DatapoolProvider>(
              builder: (context, datapoolProvider, child) {
                return Wrap(
                  spacing: 8,
                  children: datapoolProvider.storageProviders
                      .map((provider) => Chip(
                            label: Text(provider),
                            avatar: const Icon(Icons.cloud),
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

  Widget _buildDatabasesTab(BuildContext context) {
    return Consumer<DatapoolProvider>(
      builder: (context, datapoolProvider, child) {
        return ListView.builder(
          itemCount: datapoolProvider.databases.length,
          itemBuilder: (context, index) {
            final db = datapoolProvider.databases[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.storage, color: Colors.blue),
                title: Text(db['name'] ?? 'Unnamed Database'),
                subtitle: Text('Size: ${db['size'] ?? 'Unknown'} | Status: ${db['status'] ?? 'Active'}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'split') {
                      _showSplitDialog(context, db['id']);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'split',
                      child: Text('Split Database'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBackupsTab(BuildContext context) {
    return Consumer<DatapoolProvider>(
      builder: (context, datapoolProvider, child) {
        return ListView.builder(
          itemCount: datapoolProvider.backups.length,
          itemBuilder: (context, index) {
            final backup = datapoolProvider.backups[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.backup, color: Colors.green),
                title: Text(backup['name'] ?? 'Unnamed Backup'),
                subtitle: Text('Date: ${backup['date'] ?? 'Unknown'} | Size: ${backup['size'] ?? 'Unknown'}'),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddAccountDialog(BuildContext context) {
    String selectedProvider = 'Dropbox Free';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Storage Account'),
        content: Consumer<DatapoolProvider>(
          builder: (context, datapoolProvider, child) {
            return DropdownButtonFormField<String>(
              value: selectedProvider,
              items: datapoolProvider.storageProviders
                  .map((provider) => DropdownMenuItem(
                        value: provider,
                        child: Text(provider),
                      ))
                  .toList(),
              onChanged: (value) => selectedProvider = value!,
              decoration: const InputDecoration(labelText: 'Provider'),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<DatapoolProvider>().addAccount(selectedProvider, {
                'id': DateTime.now().toString(),
                'provider': selectedProvider,
                'status': 'connected',
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showSplitDialog(BuildContext context, String dbId) {
    final partsController = TextEditingController(text: '2');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Split Database'),
        content: TextField(
          controller: partsController,
          decoration: const InputDecoration(labelText: 'Number of Parts'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final parts = int.tryParse(partsController.text) ?? 2;
              context.read<DatapoolProvider>().splitDatabase(dbId, parts);
              Navigator.pop(context);
            },
            child: const Text('Split'),
          ),
        ],
      ),
    );
  }
}