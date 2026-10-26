
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/colombia_item.dart';
import '../../services/colombia_api_service.dart';

class ListingScreen extends StatefulWidget {
  final String category;

  const ListingScreen({
    super.key,
    required this.category,
  });

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final ColombiaApiService _apiService = ColombiaApiService();

  late Future<List<ColombiaItem>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    _itemsFuture = _fetchItems();
  }

  Future<List<ColombiaItem>> _fetchItems() async {
    final data = await _apiService.getList(widget.category);
    return data.map(ColombiaItem.fromJson).toList();
  }

  String get _title {
    switch (widget.category) {
      case 'Department':
        return 'Departamentos';
      case 'Region':
        return 'Regiones';
      case 'President':
        return 'Presidentes';
      case 'TouristicAttraction':
        return 'Atracciones turísticas';
      default:
        return widget.category;
    }
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
          tooltip: 'Volver al inicio',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        title: Text(_title),
      ),
      body: FutureBuilder<List<ColombiaItem>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando información de Colombia...'),
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
                      'No fue posible cargar los datos.',
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
                        setState(_loadItems);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Intentar nuevamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Text('No se encontraron resultados.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${item.id}'),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    item.description.isEmpty
                        ? 'Consulta para ver más información.'
                        : item.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.push(
                      '/detail/${widget.category}/${item.id}',
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
