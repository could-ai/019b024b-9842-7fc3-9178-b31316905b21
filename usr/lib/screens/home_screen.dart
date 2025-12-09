import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/app_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CouldAI Hoster Suite'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    'Hoster Suite',
                    Icons.cloud,
                    Colors.blue,
                    () => Navigator.pushNamed(context, '/hoster'),
                  ),
                  _buildMenuCard(
                    context,
                    'Vibe Planner',
                    Icons.psychology,
                    Colors.green,
                    () => Navigator.pushNamed(context, '/vibe'),
                  ),
                  _buildMenuCard(
                    context,
                    'DataPool Manager',
                    Icons.storage,
                    Colors.orange,
                    () => Navigator.pushNamed(context, '/datapool'),
                  ),
                  _buildMenuCard(
                    context,
                    'Project Maker',
                    Icons.build,
                    Colors.purple,
                    () => Navigator.pushNamed(context, '/project-maker'),
                  ),
                ],
              ),
            ),
            Consumer<AppProvider>(
              builder: (context, appProvider, child) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total API Cost:'),
                        Text(
                          '$${appProvider.totalCost.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<AppProvider>().selectedIndex,
        onTap: (index) {
          context.read<AppProvider>().setSelectedIndex(index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/hoster');
              break;
            case 2:
              Navigator.pushNamed(context, '/vibe');
              break;
            case 3:
              Navigator.pushNamed(context, '/datapool');
              break;
            case 4:
              Navigator.pushNamed(context, '/project-maker');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Hoster',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Vibe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'DataPool',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Maker',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}