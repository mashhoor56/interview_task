import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/feature/repository/add_repository.dart';
import 'package:interview_task/model/userModel.dart';

final AddControllerProvider = Provider(
  (ref) => AddController(productRepository: ref.watch(AddRepositoryProvider)),
);
final Streamcollection = StreamProvider(
  (ref) => ref.watch(AddControllerProvider).streamproductcontroller(),
);

class AddController {
  final AddRepository _addRepository;

  AddController({required AddRepository productRepository})
      : _addRepository = productRepository;

  itemsAddController(UserModel details) {
    _addRepository.itemsAdd(details);
  }

  Stream<List<UserModel>> streamproductcontroller() {
    return _addRepository.streamProduct();
  }

  deleteItems(UserModel detail) {
    _addRepository.deleteItems(detail);
  }

  updateitems(UserModel userModel) {
    _addRepository.updateItems(userModel);
  }
}
