import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:suroorsaz/consts/colors.dart';
import 'package:suroorsaz/consts/text_style.dart';
import 'package:suroorsaz/controllers/player_controller.dart';
import 'package:suroorsaz/pages/player.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          leading: const Icon(Icons.sort_rounded, color: whiteColor),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: whiteColor,
                )),
          ],
          title: Text(
            'SuroorSaz',
            style: ourStyle(size: 18, family: bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL,
          ),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(color: whiteColor),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Audios Found',
                  style: ourStyle(),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Obx(
                        () => ListTile(
                          title: Text(
                            snapshot.data![index].displayNameWOExt,
                            overflow: TextOverflow.ellipsis,
                            style: ourStyle(
                              family: bold,
                              size: 15,
                            ),
                          ),
                          subtitle: Text(
                            "${snapshot.data![index].artist}",
                            overflow: TextOverflow.ellipsis,
                            style: ourStyle(size: 12),
                          ),
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(
                              Icons.music_note,
                              color: whiteColor,
                              size: 30,
                            ),
                          ),
                          trailing: controller.playIndex.value == index &&
                                  controller.isPlaying.value
                              ? const Icon(
                                  Icons.pause,
                                  size: 25,
                                  color: whiteColor,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  size: 25,
                                  color: whiteColor,
                                ),
                          onTap: () {
                            Get.to(() => Player(
                                  data: snapshot.data!,
                                ));
                            controller.playAudio(
                                snapshot.data![index].uri, index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
