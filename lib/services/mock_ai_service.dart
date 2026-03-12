import '../models/mood_type.dart';

class MockAiService {
  const MockAiService();

  Future<String> generateForMood(MoodType mood) async {
    await Future.delayed(const Duration(milliseconds: 1300));

    final options = switch (mood) {
      MoodType.good => _goodMoodTexts,
      MoodType.neutral => _neutralMoodTexts,
      MoodType.bad => _badMoodTexts,
    };

    final index = DateTime.now().millisecondsSinceEpoch % options.length;
    return options[index];
  }
}

const List<String> _goodMoodTexts = [
  'Сегодня ты в ресурсе. Сделай 3 глубоких вдоха и направь эту энергию в одно важное дело.',
  'Твое спокойствие сегодня заразительно. Замедлись на минуту и поблагодари себя за прогресс.',
  'Сохрани это внутреннее тепло: вдох на 4 счета, выдох на 6, и мягкая улыбка в конце.',
];

const List<String> _neutralMoodTexts = [
  'Ты в точке баланса. На каждом выдохе отпускай лишнее напряжение в плечах и челюсти.',
  'Нормально это достаточно. Сделай паузу на 60 секунд и верни внимание к дыханию.',
  'Пусть этот день будет ровным: 5 спокойных вдохов и один маленький шаг к важной задаче.',
];

const List<String> _badMoodTexts = [
  'Сейчас можно быть уязвимым. Положи ладонь на грудь и дыши медленно: ты в безопасности.',
  'Не нужно быть идеальным сегодня. Один тихий вдох, длинный выдох, и еще чуть-чуть заботы о себе.',
  'Тяжелый момент не определяет весь день. Останься с дыханием 30 секунд и выбери самый мягкий следующий шаг.',
];
