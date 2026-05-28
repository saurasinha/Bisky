import 'dart:math' as math;

import 'package:barabar/src/screens/create_group_screen.dart';
import 'package:barabar/src/screens/join_group_screen.dart';
import 'package:barabar/src/utils.dart';
import 'package:flutter/material.dart';

class _HomeTab {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  const _HomeTab({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });
}

const _tabs = [
  _HomeTab(
    title: 'Split',
    subtitle: 'Bills',
    icon: Icons.receipt_long_rounded,
    colors: [Color(0xFF12B76A), Color(0xFF027A48)],
  ),
  _HomeTab(
    title: 'Friends',
    subtitle: 'Circles',
    icon: Icons.diversity_3_rounded,
    colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
  ),
  _HomeTab(
    title: 'Activity',
    subtitle: 'Live',
    icon: Icons.bolt_rounded,
    colors: [Color(0xFFFFB020), Color(0xFFF97316)],
  ),
  _HomeTab(
    title: 'Stats',
    subtitle: 'Money',
    icon: Icons.auto_graph_rounded,
    colors: [Color(0xFFA855F7), Color(0xFF6D28D9)],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final AnimationController _shineController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() => setState(() {}));
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = kPad(context);
    final index = _tabController.index;
    final active = _tabs[index];

    return Scaffold(
      backgroundColor: const Color(0xFF013D25),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF014B2A),
              active.colors.last,
              const Color(0xFF07150F),
            ],
            stops: const [0, 0.52, 1],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(pad, 12, pad, 0),
                child: Column(
                  children: [
                    _TopBar(shine: _shineController),
                    const SizedBox(height: 18),
                    _PremiumTabs(
                      controller: _tabController,
                      shine: _shineController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFF8FFF8), Color(0xFFF1F5F9)],
                      ),
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _SplitTab(pad: pad, shine: _shineController),
                        _LuxuryPlaceholder(
                          tab: _tabs[1],
                          title: 'Friends who make bills lighter',
                        ),
                        _LuxuryPlaceholder(
                          tab: _tabs[2],
                          title: 'Every split, beautifully tracked',
                        ),
                        _LuxuryPlaceholder(
                          tab: _tabs[3],
                          title: 'Money clarity at a glance',
                        ),
                      ],
                    ),
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

class _TopBar extends StatelessWidget {
  final Animation<double> shine;

  const _TopBar({required this.shine});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.navigation_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'BISKY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(context, 17),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xBFFFFFFF),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                'Split smartly with your inner circle',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xBFFFFFFF),
                  fontSize: sp(context, 11),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        _YearBadge(shine: shine),
        const SizedBox(width: 10),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
            border: Border.all(color: const Color(0x55FFFFFF), width: 2),
          ),
          child: const Icon(Icons.person_rounded, color: Color(0xFF233126)),
        ),
      ],
    );
  }
}

class _YearBadge extends StatelessWidget {
  final Animation<double> shine;

  const _YearBadge({required this.shine});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shine,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            gradient: SweepGradient(
              center: Alignment(-0.2 + shine.value * 0.4, -0.1),
              colors: const [
                Color(0xFFFFFFFF),
                Color(0xFFFFF2B8),
                Color(0xFFFFFFFF),
                Color(0xFFFFD166),
                Color(0xFFFFFFFF),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 16,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF7A18), Color(0xFF7C3AED)],
                  ),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'PRO',
                style: TextStyle(
                  color: const Color(0xFF111827),
                  fontSize: sp(context, 11),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PremiumTabs extends StatelessWidget {
  final TabController controller;
  final Animation<double> shine;

  const _PremiumTabs({required this.controller, required this.shine});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: AnimatedBuilder(
        animation: Listenable.merge([controller.animation, shine]),
        builder: (context, _) {
          final selected = controller.animation?.value ?? controller.index;
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final distance = (selected - index)
                  .abs()
                  .clamp(0.0, 1.0)
                  .toDouble();
              final active = 1 - distance;
              return GestureDetector(
                onTap: () => controller.animateTo(index),
                child: _TabPill(
                  tab: _tabs[index],
                  active: active,
                  shineValue: shine.value,
                ),
              );
            },
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemCount: _tabs.length,
          );
        },
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  final _HomeTab tab;
  final double active;
  final double shineValue;

  const _TabPill({
    required this.tab,
    required this.active,
    required this.shineValue,
  });

  @override
  Widget build(BuildContext context) {
    final height = 58 + active * 10;
    final width = 72 + active * 12;
    return Transform.translate(
      offset: Offset(0, (1 - active) * 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: width,
        height: height,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: active > 0.4
                ? tab.colors
                : const [Color(0x3325FF88), Color(0x2218B363)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.20 + active * 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: tab.colors.last.withValues(alpha: 0.12 + active * 0.28),
              blurRadius: 14 + active * 16,
              offset: Offset(0, 6 + active * 6),
            ),
            if (active > 0.1)
              const BoxShadow(
                color: Color(0x22000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CustomPaint(
                  painter: _GlossPainter(
                    progress: shineValue,
                    opacity: 0.08 + active * 0.18,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tab.icon, color: Colors.white, size: 22 + active * 2),
                const SizedBox(height: 5),
                Text(
                  tab.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sp(context, 11),
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                Text(
                  tab.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75 + active * 0.25),
                    fontSize: sp(context, 8),
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SplitTab extends StatelessWidget {
  final double pad;
  final Animation<double> shine;

  const _SplitTab({required this.pad, required this.shine});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(pad, 18, pad, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SearchRow(shine: shine),
          const SizedBox(height: 20),
          _PayDayBanner(shine: shine),
          const SizedBox(height: 16),
          SizedBox(
            height: 118,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: const [
                _OfferCard(
                  title: '66% OFF',
                  subtitle: 'For 15 mins',
                  icon: Icons.local_fire_department_rounded,
                  colors: [Color(0xFF16A34A), Color(0xFF047857)],
                ),
                _OfferCard(
                  title: 'Split Faster',
                  subtitle: 'Friends ready',
                  icon: Icons.flash_on_rounded,
                  colors: [Color(0xFFFFB020), Color(0xFFF97316)],
                ),
                _OfferCard(
                  title: 'Zero Stress',
                  subtitle: 'Track dues',
                  icon: Icons.verified_rounded,
                  colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _GlassStat(
                  icon: Icons.groups_rounded,
                  value: '0',
                  label: 'Groups',
                  color: const Color(0xFFFFB020),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GlassStat(
                  icon: Icons.north_east_rounded,
                  value: 'Rs 0',
                  label: 'You owe',
                  color: const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GlassStat(
                  icon: Icons.south_west_rounded,
                  value: 'Rs 0',
                  label: 'Owed',
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PrimaryAction(
                  label: 'New Group',
                  icon: Icons.add_rounded,
                  onTap: () => goTo(context, const CreateGroupScreen()),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SecondaryAction(
                  label: 'Join Group',
                  icon: Icons.link_rounded,
                  onTap: () => goTo(context, const JoinGroupScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            title: 'YOUR GROUPS',
            action: 'See all',
            color: const Color(0xFF059669),
          ),
          const SizedBox(height: 12),
          _EmptyGroupsCard(shine: shine),
          const SizedBox(height: 18),
          _AdStrip(),
        ],
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  final Animation<double> shine;

  const _SearchRow({required this.shine});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 22,
                  offset: Offset(0, 9),
                ),
              ],
              border: Border.all(color: const Color(0xFFE6F4EA)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: Color(0xFF6B7280)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Search for "groups"',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: sp(context, 13),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.mic_rounded, color: Color(0xFFF97316)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        AnimatedBuilder(
          animation: shine,
          builder: (context, _) {
            final scale = 1 + math.sin(shine.value * math.pi * 2) * 0.025;
            return Transform.scale(
              scale: scale,
              child: Container(
                width: 56,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE6F4EA)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.eco_rounded, color: Color(0xFF059669)),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PayDayBanner extends StatelessWidget {
  final Animation<double> shine;

  const _PayDayBanner({required this.shine});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shine,
      builder: (context, _) {
        return Container(
          height: 136,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00A862), Color(0xFF087443)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33059A5B),
                blurRadius: 26,
                offset: Offset(0, 14),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ConfettiPainter(progress: shine.value),
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 14,
                  child: Transform.rotate(
                    angle: -0.08,
                    child: _CashCard(shine: shine.value),
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 24,
                  child: Text(
                    'PAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(context, 38),
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 26,
                  child: Text(
                    'DAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(context, 38),
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  bottom: 20,
                  child: Row(
                    children: [
                      Container(width: 58, height: 1, color: Colors.white70),
                      const SizedBox(width: 10),
                      Text(
                        'FLAT RS 200 OFF & MORE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sp(context, 10),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 102,
                  top: 52,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF4DBC), Color(0xFFD946EF)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x55000000),
                          blurRadius: 14,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sp(context, 9),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CashCard extends StatelessWidget {
  final double shine;

  const _CashCard({required this.shine});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: const LinearGradient(
          colors: [Color(0xFF81E6A8), Color(0xFF22C55E)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _GlossPainter(progress: shine, opacity: 0.16),
            ),
          ),
          const Positioned(
            left: 12,
            top: 12,
            child: Icon(Icons.currency_rupee_rounded, color: Color(0x66005F35)),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x77005F35)),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;

  const _OfferCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.last.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const Spacer(),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: sp(context, 13),
              fontWeight: FontWeight.w900,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: sp(context, 10),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _GlassStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.18)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const Spacer(),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF111827),
              fontSize: sp(context, 16),
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: sp(context, 10),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFB020), Color(0xFFF97316)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40F97316),
              blurRadius: 18,
              offset: Offset(0, 9),
            ),
          ],
        ),
        child: _ActionContent(label: label, icon: icon, color: Colors.white),
      ),
    );
  }
}

class _SecondaryAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SecondaryAction({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD1FAE5)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: _ActionContent(
          label: label,
          icon: icon,
          color: const Color(0xFF064E3B),
        ),
      ),
    );
  }
}

class _ActionContent extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ActionContent({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: sp(context, 13),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String action;
  final Color color;

  const _SectionTitle({
    required this.title,
    required this.action,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 9),
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF111827),
            fontSize: sp(context, 11),
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Text(
          action,
          style: TextStyle(
            color: color,
            fontSize: sp(context, 11),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _EmptyGroupsCard extends StatelessWidget {
  final Animation<double> shine;

  const _EmptyGroupsCard({required this.shine});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shine,
      builder: (context, _) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFD1FAE5)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Transform.translate(
                offset: Offset(0, math.sin(shine.value * math.pi * 2) * 3),
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFF7AD), Color(0xFFFFD166)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x30F59E0B),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.handshake_rounded,
                    color: Color(0xFF0F5132),
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No groups yet',
                style: TextStyle(
                  color: const Color(0xFF111827),
                  fontSize: sp(context, 17),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Create a premium split room and invite friends to settle up beautifully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: sp(context, 12),
                  fontWeight: FontWeight.w500,
                  height: 1.45,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AdStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.campaign_outlined,
              color: Color(0xFF94A3B8),
              size: 19,
            ),
            const SizedBox(width: 8),
            Text(
              'Ad space 320 x 50',
              style: TextStyle(
                color: const Color(0xFF94A3B8),
                fontSize: sp(context, 11),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LuxuryPlaceholder extends StatelessWidget {
  final _HomeTab tab;
  final String title;

  const _LuxuryPlaceholder({required this.tab, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: tab.colors.first.withValues(alpha: 0.18)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: tab.colors),
                ),
                child: Icon(tab.icon, color: Colors.white, size: 34),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF111827),
                  fontSize: sp(context, 18),
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${tab.title} will glow here next.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF64748B),
                  fontSize: sp(context, 12),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlossPainter extends CustomPainter {
  final double progress;
  final double opacity;

  const _GlossPainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withValues(alpha: 0),
          Colors.white.withValues(alpha: opacity),
          Colors.white.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final x = (progress * 2 - 0.5) * size.width;
    final path = Path()
      ..moveTo(x - size.width * 0.4, 0)
      ..lineTo(x, 0)
      ..lineTo(x + size.width * 0.4, size.height)
      ..lineTo(x, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _GlossPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}

class _ConfettiPainter extends CustomPainter {
  final double progress;

  const _ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    const colors = [
      Color(0x33FFFFFF),
      Color(0x55B6FFCE),
      Color(0x33FFD166),
      Color(0x3300492B),
    ];

    for (var i = 0; i < 22; i++) {
      final x = ((i * 47.0) + progress * 30) % size.width;
      final y =
          ((i * 31.0) + math.sin(progress * math.pi * 2 + i) * 4) % size.height;
      paint.color = colors[i % colors.length];
      final radius = 2.0 + (i % 4);
      if (i.isEven) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      } else {
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(progress * math.pi + i);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: radius * 4, height: 3),
            const Radius.circular(2),
          ),
          paint,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
