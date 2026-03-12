import 'package:flutter/material.dart';

import '../models/mood_type.dart';
import '../services/mock_ai_service.dart';
import '../widgets/mood_option_chip.dart';

class AiMoodScreen extends StatefulWidget {
  const AiMoodScreen({super.key, this.aiService = const MockAiService()});

  final MockAiService aiService;

  @override
  State<AiMoodScreen> createState() => _AiMoodScreenState();
}

class _AiMoodScreenState extends State<AiMoodScreen> {
  MoodType? selectedMood;
  String? generatedText;
  bool isLoading = false;

  Future<void> _generateText() async {
    if (selectedMood == null || isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
      generatedText = null;
    });

    final response = await widget.aiService.generateForMood(selectedMood!);

    if (!mounted) {
      return;
    }

    setState(() {
      generatedText = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AI Настрой дня',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Выберите текущее состояние, и я сгенерирую короткую аффирмацию для фокуса.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: MoodType.values.map((mood) {
                  return MoodOptionChip(
                    mood: mood,
                    isSelected: selectedMood == mood,
                    onTap: () {
                      setState(() {
                        selectedMood = mood;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed:
                      selectedMood == null || isLoading ? null : _generateText,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: const Color(0xFF3A8970),
                  ),
                  icon: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.auto_awesome),
                  label: Text(isLoading ? 'Генерирую...' : 'Сгенерировать текст'),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD7E5DF)),
                ),
                child: Text(
                  generatedText ??
                      'Здесь появится аффирмация после выбора настроения.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: generatedText == null
                        ? Colors.black54
                        : const Color(0xFF1E2A26),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
