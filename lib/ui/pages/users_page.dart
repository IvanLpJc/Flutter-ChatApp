import 'package:chat_app/ui/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/users.dart';

class UsersPage extends StatefulWidget {
  static const String route = 'users_page';
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final users = [
    User(uuid: '1', name: 'María', email: 'maria@gmail.com', online: true),
    User(
        uuid: '2',
        name: 'Fernando',
        email: 'fernando@gmail.com',
        online: false),
    User(uuid: '3', name: 'Andrea', email: 'andrea@gmail.com', online: false),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'User Name',
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.red[400],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle_outline, color: Colors.blue[400]),
            // child: Icon(Icons.offline_bolt_outline, color: Colors.red[400]),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () => _loadUsers(),
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        child: _UsersListView(users: users),
      ),
    );
  }

  _loadUsers() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

class _UsersListView extends StatelessWidget {
  const _UsersListView({
    required this.users,
  });

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => _UserListTile(user: users[index]),
        separatorBuilder: (_, index) => const Divider(),
        itemCount: users.length);
  }
}

class _UserListTile extends StatelessWidget {
  const _UserListTile({
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          user.name.substring(0, 2),
        ),
      ),
      onTap: () => Navigator.pushNamed(context, ChatPage.route),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green[400] : Colors.red[400],
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
