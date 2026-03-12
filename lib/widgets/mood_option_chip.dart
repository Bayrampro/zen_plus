import 'package:flutter/material.dart';

import '../models/mood_type.dart';

class MoodOptionChip extends StatelessWidget {
  const MoodOptionChip({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  final MoodType mood;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? const Color(0xFFE1F2EA) : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF3A8970)
                  : const Color(0xFFD5E2DC),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(mood.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                mood.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF2F6F5B)
                      : const Color(0xFF3A4742),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
