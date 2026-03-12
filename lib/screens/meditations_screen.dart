import 'package:flutter/material.dart';

import '../models/meditation_item.dart';
import '../widgets/meditation_session_card.dart';

class MeditationsScreen extends StatelessWidget {
  const MeditationsScreen({
    super.key,
    required this.isSubscribed,
    required this.onOpenPaywall,
  });

  final bool isSubscribed;
  final VoidCallback onOpenPaywall;

  static const List<MeditationItem> _sessions = [
    MeditationItem(
      id: 'morning-breath',
      title: 'Осознанное дыхание утром',
      durationLabel: '7 мин',
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?auto=format&fit=crop&w=400&q=80',
      isPremium: false,
    ),
    MeditationItem(
      id: 'focus-reset',
      title: 'Фокус и концентрация',
      durationLabel: '10 мин',
      imageUrl:
          'https://images.unsplash.com/photo-1499209974431-9dddcece7f88?auto=format&fit=crop&w=400&q=80',
      isPremium: false,
    ),
    MeditationItem(
      id: 'anxiety-release',
      title: 'Снятие тревоги перед сном',
      durationLabel: '12 мин',
      imageUrl:
          'https://images.unsplash.com/photo-1447452001602-7090c7ab2db3?auto=format&fit=crop&w=400&q=80',
      isPremium: true,
    ),
    MeditationItem(
      id: 'deep-relax',
      title: 'Глубокое расслабление',
      durationLabel: '15 мин',
      imageUrl:
          'https://images.unsplash.com/photo-1470115636492-6d2b56f9146d?auto=format&fit=crop&w=400&q=80',
      isPremium: true,
    ),
    MeditationItem(
      id: 'gratitude-evening',
      title: 'Вечерняя благодарность',
      durationLabel: '8 мин',
      imageUrl:
          'https://images.unsplash.com/photo-1476611338391-6f395a0ebc7b?auto=format&fit=crop&w=400&q=80',
      isPremium: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Медитации',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Выберите сессию на сегодня',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black54,
                ),
              ),
              if (!isSubscribed) ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF3EF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFCFE2DA)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline, color: Color(0xFF3C6F60)),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Часть медитаций доступна только в Premium',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF3B4C47),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: onOpenPaywall,
                        child: const Text('Открыть'),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: _sessions.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final session = _sessions[index];
                    final isLocked = !isSubscribed && session.isPremium;

                    return MeditationSessionCard(
                      item: session,
                      isLocked: isLocked,
                      onTap: () {
                        if (isLocked) {
                          onOpenPaywall();
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Запуск: ${session.title}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
