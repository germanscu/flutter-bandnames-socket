import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    //socketService.socket.emit(event)

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Server Status: ${socketService.serverStatus}')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            //tarea
            //emitir: emitir-mensaje
            // {nombre: 'flutter', mensaje: 'hola desde flutter'}
            socketService.emit('emitir-mensaje',
                {'nombre': 'flutter', 'mensaje': 'hola desde flutter'});
          }),
    );
  }
}
