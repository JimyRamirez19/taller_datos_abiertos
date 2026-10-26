
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/colombia_api_service.dart';

class DetailScreen extends StatefulWidget {
  final String category;
  final String id;

  const DetailScreen({
    super.key,
    required this.category,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final ColombiaApiService _apiService;
  late Future<Map<String, dynamic>> _detailFuture;

  @override
  void initState() {
    super.initState();
    _apiService = ColombiaApiService();
    _loadDetail();
  }

  void _loadDetail() {
    _detailFuture = _apiService.getDetail(
      widget.category,
      widget.id,
    );
  }

  String _formatKey(String key) {
    final formatted = key
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (match) => '${match[1]} ${match[2]}',
        )
        .replaceAll('_', ' ');

    if (formatted.isEmpty) {
      return key;
    }

    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  String _formatValue(dynamic value) {
    if (value == null) {
      return 'No disponible';
    }

    if (value is Map || value is List) {
      return const JsonEncoder.withIndent('  ').convert(value);
    }

    if (value.toString().trim().isEmpty) {
      return 'No disponible';
    }

    return value.toString();
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Volver al listado',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/listing/${widget.category}');
            }
          },
        ),
        title: const Text('Detalle del elemento'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando detalle...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 56,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No fue posible cargar el detalle.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(_loadDetail);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Intentar nuevamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final detail = snapshot.data;

          if (detail == null || detail.isEmpty) {
            return const Center(
              child: Text('No hay información disponible.'),
            );
          }

          final entries = detail.entries.toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatKey(entry.key),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        _formatValue(entry.value),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
