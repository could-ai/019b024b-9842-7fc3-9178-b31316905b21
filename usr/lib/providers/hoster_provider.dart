import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HosterProvider extends ChangeNotifier {
  // Hoster tools management
  List<Map<String, dynamic>> _hostedTools = [];
  List<Map<String, dynamic>> get hostedTools => _hostedTools;
  
  // Tool types: api_server, mcp_server, database, webhook, etc.
  List<String> _toolTypes = ['API Server', 'MCP Server', 'Database', 'Webhook', 'Container'];
  List<String> get toolTypes => _toolTypes;
  
  // Add a new hosted tool
  void addTool(Map<String, dynamic> tool) {
    _hostedTools.add(tool);
    notifyListeners();
  }
  
  // Remove a tool
  void removeTool(String id) {
    _hostedTools.removeWhere((tool) => tool['id'] == id);
    notifyListeners();
  }
  
  // Update tool status
  void updateToolStatus(String id, String status) {
    final index = _hostedTools.indexWhere((tool) => tool['id'] == id);
    if (index != -1) {
      _hostedTools[index]['status'] = status;
      notifyListeners();
    }
  }
  
  // Monitor tools (placeholder for actual monitoring)
  Future<void> monitorTools() async {
    // Implement monitoring logic here
    for (var tool in _hostedTools) {
      // Check health, performance, etc.
      updateToolStatus(tool['id'], 'healthy');
    }
  }
}