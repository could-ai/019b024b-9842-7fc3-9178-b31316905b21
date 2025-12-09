import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VibeProvider extends ChangeNotifier {
  // AI model settings
  String _selectedModel = 'gemini-pro'; // Default to Gemini
  List<String> _availableModels = ['gemini-pro', 'gpt-3.5-turbo', 'claude-haiku'];
  
  String get selectedModel => _selectedModel;
  List<String> get availableModels => _availableModels;
  
  void setSelectedModel(String model) {
    _selectedModel = model;
    notifyListeners();
  }
  
  // API keys (will be stored securely via Supabase)
  Map<String, String> _apiKeys = {};
  
  void setApiKey(String provider, String key) {
    _apiKeys[provider] = key;
    notifyListeners();
  }
  
  // Background knowledge
  List<String> _backgroundInfo = [];
  List<String> get backgroundInfo => _backgroundInfo;
  
  void addBackgroundInfo(String info) {
    _backgroundInfo.add(info);
    notifyListeners();
  }
  
  void removeBackgroundInfo(int index) {
    _backgroundInfo.removeAt(index);
    notifyListeners();
  }
  
  // AI Character presets
  List<Map<String, dynamic>> _characterPresets = [
    {
      'name': 'Code Assistant',
      'description': 'Helps with programming and development',
      'prompt': 'You are an expert programmer...'
    },
    {
      'name': 'System Architect',
      'description': 'Designs system architectures',
      'prompt': 'You are a system architect...'
    }
  ];
  
  List<Map<String, dynamic>> get characterPresets => _characterPresets;
  
  void addCharacterPreset(Map<String, dynamic> preset) {
    _characterPresets.add(preset);
    notifyListeners();
  }
  
  // Vibe planning and orchestration
  List<Map<String, dynamic>> _workflows = [];
  List<Map<String, dynamic>> get workflows => _workflows;
  
  void addWorkflow(Map<String, dynamic> workflow) {
    _workflows.add(workflow);
    notifyListeners();
  }
  
  void removeWorkflow(String id) {
    _workflows.removeWhere((wf) => wf['id'] == id);
    notifyListeners();
  }
  
  // Generate plan using AI
  Future<Map<String, dynamic>> generateVibePlan(String description) async {
    // This will call Supabase Edge Function for AI planning
    return {
      'id': DateTime.now().toString(),
      'description': description,
      'steps': [],
      'cost': 0.0
    };
  }
}