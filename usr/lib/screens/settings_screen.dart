import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionHeader('API Connections'),
            _buildApiKeyTile('Gemini API Key'),
            _buildApiKeyTile('OpenAI API Key'),
            _buildApiKeyTile('Anthropic API Key'),
            const Divider(),
            _buildSectionHeader('AI Model Settings'),
            _buildModelPreferenceTile(),
            const Divider(),
            _buildSectionHeader('Cost Control'),
            _buildCostLimitTile(),
            _buildCostAlertTile(),
            const Divider(),
            _buildSectionHeader('Container Settings'),
            _buildDockerSwarmTile(),
            _buildNetworkConfigTile(),
            const Divider(),
            _buildSectionHeader('Appearance'),
            _buildThemeToggleTile(),
            _buildLanguageTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildApiKeyTile(String title) {
    return ListTile(
      title: Text(title),
      subtitle: const Text('Not configured'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement API key configuration via Supabase Edge Functions
      },
    );
  }

  Widget _buildModelPreferenceTile() {
    return ListTile(
      title: const Text('Preferred AI Model'),
      subtitle: const Text('Gemini Pro'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement model selection
      },
    );
  }

  Widget _buildCostLimitTile() {
    return ListTile(
      title: const Text('Monthly Cost Limit'),
      subtitle: const Text('$50.00'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement cost limit setting
      },
    );
  }

  Widget _buildCostAlertTile() {
    return SwitchListTile(
      title: const Text('Cost Alerts'),
      subtitle: const Text('Get notified when approaching limits'),
      value: true,
      onChanged: (value) {
        // TODO: Implement cost alerts toggle
      },
    );
  }

  Widget _buildDockerSwarmTile() {
    return ListTile(
      title: const Text('Docker Swarm Config'),
      subtitle: const Text('Configure distributed network'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement Docker Swarm configuration
      },
    );
  }

  Widget _buildNetworkConfigTile() {
    return ListTile(
      title: const Text('Network Configuration'),
      subtitle: const Text('Multi-device workload distribution'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement network configuration
      },
    );
  }

  Widget _buildThemeToggleTile() {
    return SwitchListTile(
      title: const Text('Dark Mode'),
      subtitle: const Text('Toggle dark/light theme'),
      value: false,
      onChanged: (value) {
        // TODO: Implement theme toggle
      },
    );
  }

  Widget _buildLanguageTile() {
    return ListTile(
      title: const Text('Language'),
      subtitle: const Text('English'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement language selection
      },
    );
  }
}