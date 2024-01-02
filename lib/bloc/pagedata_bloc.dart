import 'package:fetch_api_using_provider_part2/bloc/pagedata_events.dart';
import 'package:fetch_api_using_provider_part2/bloc/pagedata_states.dart';
import 'package:fetch_api_using_provider_part2/provider/PageProvider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
