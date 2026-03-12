enum MoodType {
  good,
  neutral,
  bad,
}

extension MoodTypeUi on MoodType {
  String get emoji {
    switch (this) {
      case MoodType.good:
        return '😊';
      case MoodType.neutral:
        return '😐';
      case MoodType.bad:
        return '😔';
    }
  }

  String get title {
    switch (this) {
      case MoodType.good:
        return 'Хорошо';
      case MoodType.neutral:
        return 'Нормально';
      case MoodType.bad:
        return 'Плохо';
    }
  }
}
