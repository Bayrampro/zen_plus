class MeditationItem {
  const MeditationItem({
    required this.id,
    required this.title,
    required this.durationLabel,
    required this.imageUrl,
    required this.isPremium,
  });

  final String id;
  final String title;
  final String durationLabel;
  final String imageUrl;
  final bool isPremium;
}
