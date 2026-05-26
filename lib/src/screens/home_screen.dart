import 'package:flutter/material.dart';
import 'package:barabar/src/screens/create_group_screen.dart';
import 'package:barabar/src/screens/join_group_screen.dart';
import 'package:barabar/src/theme.dart';
import 'package:barabar/src/utils.dart';
import 'package:barabar/src/widgets/common_widgets.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Tab colour definitions — matches the screenshot exactly
// ─────────────────────────────────────────────────────────────────────────────
class _TabStyle {
  final String label;
  final Color activeBg;
  final Color activeText;
  final Color inactiveText;
  const _TabStyle({
    required this.label,
    required this.activeBg,
    required this.activeText,
    this.inactiveText = const Color(0xFF444444),
  });
}

const _tabStyles = [
  _TabStyle(
    label: 'BISKY',
    activeBg: Color(0xFFF5C842),   // yellow/saffron pill
    activeText: Color(0xFFD44FA0), // pink text
  ),
  _TabStyle(
    label: 'Friends',
    activeBg: Colors.white,
    activeText: Color(0xFF3A8FD6), // blue
  ),
  _TabStyle(
    label: 'Activity',
    activeBg: Colors.white,
    activeText: Color(0xFF1A1A1A), // near-black
  ),
  _TabStyle(
    label: 'Stats',
    activeBg: Colors.white,
    activeText: Color(0xFF7B4FD4), // purple
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// HomeScreen
// ─────────────────────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _tabStyles.length, vsync: this);
    _tab.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final p = kPad(ctx);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3C4), // warm cream — entire page bg
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ═══════════════════════════════════════════════════════════════
            // CREAM HEADER — sits directly on the yellow background
            // ═══════════════════════════════════════════════════════════════
            Padding(
              padding: EdgeInsets.fromLTRB(p, p * 0.5, p, p * 0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Row 1: greeting + wallet + avatar ───────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.flash_on,
                          color: Color(0xFF1A1A1A), size: 26),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Welcome user',
                          style: TextStyle(
                            fontSize: sp(ctx, 26),
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      // wallet badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.06),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B4FD4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '₹0',
                              style: TextStyle(
                                fontSize: sp(ctx, 14),
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // avatar
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFFDDDDDD), width: 1.5),
                        ),
                        child: const Icon(Icons.person,
                            color: Color(0xFF888888), size: 22),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── Row 2: pill tabs ────────────────────────────────────
                  // Only the ACTIVE tab gets the yellow fill.
                  // Inactive tabs are white pills with coloured text.
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(_tabStyles.length, (i) {
                        final isActive = _tab.index == i;
                        final s = _tabStyles[i];
                        return Padding(
                          padding: EdgeInsets.only(
                              right: i < _tabStyles.length - 1 ? 8 : 0),
                          child: GestureDetector(
                            onTap: () => _tab.animateTo(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 11),
                              decoration: BoxDecoration(
                                color: isActive ? s.activeBg : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isActive
                                      ? s.activeBg
                                      : const Color(0xFFE0E0E0),
                                  width: 1.5,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                s.label,
                                style: TextStyle(
                                  fontSize: sp(ctx, 14),
                                  fontWeight: FontWeight.w800,
                                  color: isActive
                                      ? s.activeText
                                      : s.activeText, // always coloured
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // ═══════════════════════════════════════════════════════════════
            // WHITE BODY — rounded top corners, rest of page
            // ═══════════════════════════════════════════════════════════════
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFDF8F0), // very light warm white
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  child: TabBarView(
                    controller: _tab,
                    children: [
                      _BiskyTab(p: p),
                      Center(
                          child: Text('Friends',
                              style: TextStyle(
                                  fontSize: sp(ctx, 18),
                                  fontWeight: FontWeight.w700,
                                  color: C.textPrimary))),
                      Center(
                          child: Text('Activity',
                              style: TextStyle(
                                  fontSize: sp(ctx, 18),
                                  fontWeight: FontWeight.w700,
                                  color: C.textPrimary))),
                      Center(
                          child: Text('Stats',
                              style: TextStyle(
                                  fontSize: sp(ctx, 18),
                                  fontWeight: FontWeight.w700,
                                  color: C.textPrimary))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BISKY tab content (scrollable body inside white section)
// ─────────────────────────────────────────────────────────────────────────────
class _BiskyTab extends StatelessWidget {
  final double p;
  const _BiskyTab({required this.p});

  @override
  Widget build(BuildContext ctx) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(p, p * 0.8, p, p * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Search + Eid chip ────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.04),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search,
                          color: Color(0xFFAAAAAA), size: 20),
                      const SizedBox(width: 10),
                      Text(
                        'Search for "groups"',
                        style: TextStyle(
                          color: const Color(0xFFAAAAAA),
                          fontSize: sp(ctx, 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Celebrate Eid chip
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: C.saffron,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.star,
                          color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Celebrate',
                            style: TextStyle(
                              fontSize: sp(ctx, 11),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF3A8FD6),
                            )),
                        Text('Diwali',
                            style: TextStyle(
                              fontSize: sp(ctx, 11),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF3A8FD6),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Stat cards ───────────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: _MiniStatCard(
                icon: Icons.group_outlined,
                iconColor: const Color(0xFFF5A623),
                label: 'Groups',
                value: '0',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _MiniStatCard(
                icon: Icons.arrow_upward_rounded,
                iconColor: const Color(0xFFE05A4E),
                label: 'You Owe',
                value: '₹0',
                valueColor: const Color(0xFFE05A4E),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _MiniStatCard(
                icon: Icons.arrow_downward_rounded,
                iconColor: const Color(0xFF2ECC71),
                label: 'Owed to You',
                value: '₹0',
                valueColor: const Color(0xFF2ECC71),
              ),
            ),
          ]),

          const SizedBox(height: 14),

          // ── Action buttons ───────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () => goTo(ctx, const CreateGroupScreen()),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623), // orange
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_rounded,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 6),
                      Text('New Group',
                          style: TextStyle(
                            fontSize: sp(ctx, 14),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => goTo(ctx, const JoinGroupScreen()),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.link_rounded,
                          color: Color(0xFF888888), size: 18),
                      const SizedBox(width: 6),
                      Text('Join Group',
                          style: TextStyle(
                            fontSize: sp(ctx, 14),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF555555),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ]),

          const SizedBox(height: 20),

          // ── YOUR GROUPS header ───────────────────────────────────────────
          Row(children: [
            Container(
              width: 3,
              height: 14,
              decoration: BoxDecoration(
                color: C.saffron,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'YOUR GROUPS',
              style: TextStyle(
                fontSize: sp(ctx, 10),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF888888),
                letterSpacing: 1.4,
              ),
            ),
            const Spacer(),
            Text(
              'See all',
              style: TextStyle(
                fontSize: sp(ctx, 11),
                color: C.saffron,
                fontWeight: FontWeight.w600,
              ),
            ),
          ]),

          const SizedBox(height: 12),

          // ── Empty state card ─────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(children: [
              // Indian flag dots
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    ColorDot(C.flagSaffron),
                    SizedBox(width: 5),
                    ColorDot(C.flagWhite),
                    SizedBox(width: 5),
                    ColorDot(C.flagGreen),
                  ]),
              const SizedBox(height: 16),
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                    child: Text('🤝', style: TextStyle(fontSize: 28))),
              ),
              const SizedBox(height: 14),
              Text('No groups yet',
                  style: TextStyle(
                    fontSize: sp(ctx, 15),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  )),
              const SizedBox(height: 6),
              Text(
                'Create a group and invite your\nfriends to start splitting bills',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sp(ctx, 12),
                  color: const Color(0xFF888888),
                  height: 1.5,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small stat card widget used in the 3-up row
// ─────────────────────────────────────────────────────────────────────────────
class _MiniStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color? valueColor;

  const _MiniStatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: sp(ctx, 16),
              fontWeight: FontWeight.w800,
              color: valueColor ?? const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: sp(ctx, 10),
              color: const Color(0xFF999999),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}