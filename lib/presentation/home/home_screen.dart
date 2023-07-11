import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';

class HomeScreen extends HookConsumerWidget {
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final state = ref.watch(homeProvider);
    // final authState = ref.watch(authProvider);
    // final searchController = useTextEditingController();

    // final isSelectedType = useState(0);
    ref.listen(homeProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
      print("length ==> ${state.pokemonDataRes.pokemons?.length}");
    });

    useEffect(() {
      Future.wait([
        // Future.microtask(() => ref.read(carServiceProvider.notifier).getYear()),
        // Future.microtask(
        //     () => ref.read(carServiceProvider.notifier).getAllProblems()),
      ]);
      return null;
    }, []);

    //f53d2d

    return Scaffold(
      appBar: AppBar(
        title: Text(context.local.home),
        centerTitle: false,
        actions: const [],
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: state.loading
            ? const Center(
                child: Text("Loading..."),
              )
            : ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: state.pokemonDataRes.pokemons?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final pokemon = state.pokemonDataRes.pokemons![index];

                  return ListTile(
                      title: Text(pokemon.name!),
                      subtitle: Text(pokemon.classification!),
                      leading: Image.network(pokemon.image!),
                      trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Weight: ${pokemon.weight!.maximum!}'),
                            Text('Height: ${pokemon.height!.maximum!}'),
                          ]));
                },
              ),
      ),
    );
  }
}
