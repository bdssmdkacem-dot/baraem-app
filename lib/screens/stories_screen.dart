import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/stories_data.dart';
import '../providers/progress_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/premium_sheet.dart';
import 'story_detail_screen.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('قصص الأنبياء')),
        body: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            final locked = story.isPremium && !progress.isPremium;
            final done = progress.isCompleted(story.id);

            return GestureDetector(
              onTap: () {
                if (locked) {
                  PremiumSheet.show(context);
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => StoryDetailScreen(story: story)),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book_rounded,
                            size: 48,
                            color: locked ? AppColors.locked : AppColors.primaryCoral,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            story.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: locked ? AppColors.locked : AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (locked)
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Icon(Icons.lock_rounded, color: AppColors.locked),
                      ),
                    if (done)
                      const Positioned(
                        top: 10,
                        left: 10,
                        child: Icon(Icons.check_circle_rounded, color: AppColors.success),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
