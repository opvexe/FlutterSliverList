import 'dart:async';
import './listModel.dart';
import './listViewModel.dart';

class ListBloc {
  
  final listViewModel viewModel = listViewModel();
  final listController = StreamController<List<listModel>>();
  final fabController =StreamController<bool>();
  final fabVisibleController =StreamController<bool>();
  Sink<bool> get fabSink => fabController.sink;
  Stream<List<listModel>> get listItems => listController.stream;
  Stream<bool> get fabVisible => fabVisibleController.stream;

  ListBloc(){
    listController.add(viewModel.getSouce());
    fabController.stream.listen(onScroll);
  }

  onScroll(bool visible){
    fabVisibleController.add(visible);
  }
  
   void dispose() {
    listController?.close();
    fabController?.close();
    fabVisibleController?.close();
  }
}