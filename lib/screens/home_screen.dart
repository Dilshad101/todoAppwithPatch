import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/widgets/snackbar.dart';
import 'package:todo_app/widgets/task_container.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(InitTaskEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task '),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Your Tasks',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<TaskBloc, TaskState>(
                listenWhen: (previous, current) => current is TaskActionState,
                listener: (context, state) {
                  if (state is TaskEditedState) {
                    showSnackBarMessenger(
                        context: context,
                        color: Colors.green,
                        msg: 'Task Edited Successfully');
                  } else if (state is TaskDeletedState) {
                    showSnackBarMessenger(
                        context: context,
                        msg: 'Task Deleted',
                        color: Colors.redAccent);
                  }
                },
                buildWhen: (previous, current) => current is! TaskActionState,
                builder: (context, state) {
                  if (state is TaskFetchSuccessfullState) {
                    final taskList = state.taskList;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / .8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final data = taskList[index];

                        return TaskContainer(data: data);
                      },
                      itemCount: taskList.length,
                    );
                  } else if (state is TaskLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Text(
                        'No Data Found',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
