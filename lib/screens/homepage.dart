import 'package:fetch_api_using_provider_part2/bloc/pagedata_bloc.dart';
import 'package:fetch_api_using_provider_part2/bloc/pagedata_events.dart';
import 'package:fetch_api_using_provider_part2/bloc/pagedata_states.dart';
import 'package:fetch_api_using_provider_part2/model/model.dart';
import 'package:fetch_api_using_provider_part2/provider/PageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(title: const Text('The BloC App')), body: blocBody()),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(child: Text("Error"));
          }
          if (state is UserLoadedState) {
            List<Data> userList = state.users;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15)),
                          height: 80,
                          child: ListTile(
                              title: Text(
                                'Name : ${userList[index].firstName}  ${userList[index].lastName}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                'Email : ${userList[index].email}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    userList[index].avatar.toString(),
                                  ),
                                ),
                              ))));
                });
          }

          return Container();
        },
      ),
    );
  }
}
