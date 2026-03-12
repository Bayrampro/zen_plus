import 'package:flutter/material.dart';

import '../widgets/plan_option_card.dart';
import '../widgets/premium_benefit_tile.dart';

enum BillingPlan { monthly, yearly }

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({
    super.key,
    required this.onTryFree,
    this.onClose,
  });

  final VoidCallback onTryFree;
  final VoidCallback? onClose;

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  BillingPlan selectedPlan = BillingPlan.yearly;

  final List<_BenefitItem> _benefits = const [
    _BenefitItem(
      icon: Icons.self_improvement,
      title: 'Премиум медитации',
      subtitle: 'Доступ ко всей библиотеке без ограничений',
    ),
    _BenefitItem(
      icon: Icons.auto_awesome,
      title: 'AI-настрой дня',
      subtitle: 'Персональные аффирмации под ваше состояние',
    ),
    _BenefitItem(
      icon: Icons.offline_bolt,
      title: 'Режим офлайн',
      subtitle: 'Слушайте медитации даже без интернета',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ZenPulse Premium',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.onClose != null) ...[
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: widget.onClose,
                    icon: const Icon(Icons.close),
                    label: const Text('Закрыть'),
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Разблокируйте полный доступ к медитациям и AI-подсказкам.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _benefits.length,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final benefit = _benefits[index];
                  return PremiumBenefitTile(
                    icon: benefit.icon,
                    title: benefit.title,
                    subtitle: benefit.subtitle,
                  );
                },
              ),
              const SizedBox(height: 22),
              PlanOptionCard(
                title: 'Месячный',
                subtitle: 'Гибкая подписка',
                price: '₽499/мес',
                isSelected: selectedPlan == BillingPlan.monthly,
                onTap: () {
                  setState(() {
                    selectedPlan = BillingPlan.monthly;
                  });
                },
              ),
              const SizedBox(height: 12),
              PlanOptionCard(
                title: 'Годовой',
                subtitle: 'Лучшее предложение',
                price: '₽3 490/год',
                badgeText: 'Выгода 40%',
                isSelected: selectedPlan == BillingPlan.yearly,
                onTap: () {
                  setState(() {
                    selectedPlan = BillingPlan.yearly;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: const Color(0xFF3A8970),
                    textStyle: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: widget.onTryFree,
                  child: const Text('Попробовать бесплатно'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '7 дней бесплатно, отмена в любой момент',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ),
              if (widget.onClose != null) ...[
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: widget.onClose,
                    child: const Text('Продолжить без Premium'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitItem {
  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}
