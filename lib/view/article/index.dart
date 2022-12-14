import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:bush_market/controller/pepNotes.dart';
import 'package:bush_market/core/global_variables.dart';
import 'package:bush_market/core/theme/styles.dart';
import 'package:bush_market/view/article/article_department.dart';
import 'package:bush_market/view/article/pep/pepNotesList.dart';
import 'package:bush_market/view/bookmark/bookmark_page.dart';
import 'package:bush_market/view/widgets/dashboard_card.dart';
import 'package:bush_market/view/widgets/loading.dart';
import 'package:bush_market/view/widgets/widgets.dart';

part 'department.dart';

class ArticlesDashboard extends StatefulWidget {
  const ArticlesDashboard({Key? key}) : super(key: key);

  @override
  State<ArticlesDashboard> createState() => _ArticlesDashboardState();
}

class _ArticlesDashboardState extends State<ArticlesDashboard> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notes",
          style: Styles.headlineText2!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: MyWidgets.fab(
        icon: Icons.bookmark,
        onTap: () => Get.to(
            BookmarkPage(bookmark: Bookmark.notes, title: 'Saved Notes ')),
      ),
      body: ListView(
        controller: controller,
        children: [
          dashboardCard(
            context,
            title: "PEP",
            page: PepNotesPageList(
              imgUrl: "assets/images/ladyexam.jpg",
              sectionTitle: "PEP",
              futureList: PepDb.getAllNotes(),
            ),
            subtitle: 'For Nigerians',
          ),
          FutureBuilder(
            future: MyGlobals.notesDepartment.get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Loading.spinKitFadingCircle();
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot postDoc = snapshot.data!.docs[index];

                    final Department dd = Department.fromMap(
                        postDoc.data() as Map<String, dynamic>);
                    return dashboardCard(
                      context,
                      title: dd.title,
                      page: ArticlesDepartmentPage(title: dd.title),
                      subtitle: 'Departments',
                    );
                  });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.refresh,
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
