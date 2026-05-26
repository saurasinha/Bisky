import 'package:flutter/material.dart';
import 'package:barabar/src/screens/create_group_screen.dart';
import 'package:barabar/src/screens/join_group_screen.dart';
import 'package:barabar/src/theme.dart';
import 'package:barabar/src/utils.dart';
import 'package:barabar/src/widgets/common_widgets.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Tab metadata
// ─────────────────────────────────────────────────────────────────────────────
class _TabMeta {
  final String? label;      // null for the logo tab
  final bool isLogo;
  final Color activeText;

  const _TabMeta({
    this.label,
    this.isLogo = false,
    this.activeText = const Color(0xFF1A1A1A),
  });
}

const _tabs = [
  _TabMeta(isLogo: true,  activeText: Color(0xFFD44FA0)),  // logo tab
  _TabMeta(label: 'Friends',  activeText: Color(0xFF3A8FD6)),
  _TabMeta(label: 'Activity', activeText: Color(0xFF1A1A1A)),
  _TabMeta(label: 'Stats',    activeText: Color(0xFF7B4FD4)),
];

// The yellow that the cream header uses — active tab must match this exactly
// so the "merge" works visually.
const _headerYellow = Color(0xFFFDD835);
// The white body colour — inactive tab bottom must match this.
const _bodyWhite    = Color(0xFFF5F0E8);

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
    _tab = TabController(length: _tabs.length, vsync: this);
    _tab.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final p  = kPad(ctx);
    final idx = _tab.index;

    return Scaffold(
      backgroundColor: _headerYellow,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ═══════════════════════════════════════════════════════════════
            // YELLOW HEADER
            // ═══════════════════════════════════════════════════════════════
            Padding(
              padding: EdgeInsets.fromLTRB(p, p * 0.5, p, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Row: greeting + wallet + avatar ─────────────────────
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
                            horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.06),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B4FD4),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text('₹0',
                                style: TextStyle(
                                  fontSize: sp(ctx, 14),
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF1A1A1A),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // avatar
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFFDDDDDD), width: 1.5),
                        ),
                        child: const Icon(Icons.person,
                            color: Color(0xFF888888), size: 20),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ── BROWSER-STYLE TABS ───────────────────────────────────
                  // Each tab is a rounded-top rectangle. The active tab:
                  //   • has white background (matches body)
                  //   • has NO bottom border → merges into the white body
                  //   • sits slightly lower to overlap the body border
                  // Inactive tabs:
                  //   • transparent bg (shows yellow)
                  //   • have a bottom border matching the body colour
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(_tabs.length, (i) {
                        final isActive = idx == i;
                        final meta = _tabs[i];
                        return GestureDetector(
                          onTap: () => _tab.animateTo(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            // active tab is taller so it visually "lifts"
                            margin: EdgeInsets.only(
                              right: 2,
                              top: isActive ? 0 : 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 11),
                            decoration: BoxDecoration(
                              color: isActive ? _bodyWhite : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              border: Border(
                                top: BorderSide(
                                  color: isActive
                                      ? const Color(0xFFE0D8CC)
                                      : Colors.transparent,
                                  width: 1,
                                ),
                                left: BorderSide(
                                  color: isActive
                                      ? const Color(0xFFE0D8CC)
                                      : Colors.transparent,
                                  width: 1,
                                ),
                                right: BorderSide(
                                  color: isActive
                                      ? const Color(0xFFE0D8CC)
                                      : Colors.transparent,
                                  width: 1,
                                ),
                                bottom: BorderSide.none, // KEY: no bottom border
                              ),
                            ),
                            child: _tabChild(ctx, i, isActive, meta),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // ═══════════════════════════════════════════════════════════════
            // WHITE BODY — seamlessly continues from the active tab
            // ═══════════════════════════════════════════════════════════════
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _bodyWhite,
                  border: const Border(
                    top: BorderSide(color: Color(0xFFE0D8CC), width: 1),
                  ),
                ),
                child: TabBarView(
                  controller: _tab,
                  children: [
                    _BiskyTab(p: p),
                    Center(child: Text('Friends',
                        style: TextStyle(fontSize: sp(ctx, 18),
                            fontWeight: FontWeight.w700, color: C.textPrimary))),
                    Center(child: Text('Activity',
                        style: TextStyle(fontSize: sp(ctx, 18),
                            fontWeight: FontWeight.w700, color: C.textPrimary))),
                    Center(child: Text('Stats',
                        style: TextStyle(fontSize: sp(ctx, 18),
                            fontWeight: FontWeight.w700, color: C.textPrimary))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabChild(BuildContext ctx, int i, bool isActive, _TabMeta meta) {
    if (meta.isLogo) {
      // Logo tab: show the app logo image
      return Image.asset(
        'assets/images/bisky.png',
        height: 22,
        // tint the logo to the pink colour when active, grey when not
        color: isActive ? meta.activeText : const Color(0xFF888888),
        colorBlendMode: BlendMode.srcIn,
        errorBuilder: (_, __, ___) => Text(
          'BISKY',
          style: TextStyle(
            fontSize: sp(ctx, 14),
            fontWeight: FontWeight.w900,
            color: isActive ? meta.activeText : const Color(0xFF888888),
          ),
        ),
      );
    }
    return Text(
      meta.label!,
      style: TextStyle(
        fontSize: sp(ctx, 14),
        fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
        color: isActive ? meta.activeText : const Color(0xFF888888),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BISKY tab body
// ─────────────────────────────────────────────────────────────────────────────
class _BiskyTab extends StatelessWidget {
  final double p;
  const _BiskyTab({required this.p});

  @override
  Widget build(BuildContext ctx) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(p, p * 0.8, p, p * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Search + festival chip ───────────────────────────────────────
          Row(children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.04),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(children: [
                  const Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
                  const SizedBox(width: 10),
                  Text('Search for "groups"',
                      style: TextStyle(
                          color: const Color(0xFFAAAAAA),
                          fontSize: sp(ctx, 13))),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            // Festival chip — repurposable ad/promo slot
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5A623),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 15),
                ),
                const SizedBox(width: 7),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Celebrate',
                        style: TextStyle(
                          fontSize: sp(ctx, 10),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3A8FD6),
                        )),
                    Text('Diwali',
                        style: TextStyle(
                          fontSize: sp(ctx, 10),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3A8FD6),
                        )),
                  ],
                ),
              ]),
            ),
          ]),

          const SizedBox(height: 14),

          // ── Stat cards ───────────────────────────────────────────────────
          Row(children: [
            Expanded(child: _StatCard(
              icon: Icons.group_outlined,
              iconColor: const Color(0xFFF5A623),
              label: 'Groups', value: '0',
            )),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(
              icon: Icons.arrow_upward_rounded,
              iconColor: const Color(0xFFE05A4E),
              label: 'You Owe', value: '₹0',
              valueColor: const Color(0xFFE05A4E),
            )),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(
              icon: Icons.arrow_downward_rounded,
              iconColor: const Color(0xFF2ECC71),
              label: 'Owed to You', value: '₹0',
              valueColor: const Color(0xFF2ECC71),
            )),
          ]),

          const SizedBox(height: 12),

          // ── Action buttons ───────────────────────────────────────────────
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () => goTo(ctx, const CreateGroupScreen()),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5A623),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_rounded, color: Colors.white, size: 20),
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
            )),
            const SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () => goTo(ctx, const JoinGroupScreen()),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFDDDDDD)),
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
            )),
          ]),

          const SizedBox(height: 20),

          // ── YOUR GROUPS ──────────────────────────────────────────────────
          Row(children: [
            Container(
              width: 3, height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFFF5A623),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text('YOUR GROUPS',
                style: TextStyle(
                  fontSize: sp(ctx, 10),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF888888),
                  letterSpacing: 1.4,
                )),
            const Spacer(),
            Text('See all',
                style: TextStyle(
                  fontSize: sp(ctx, 11),
                  color: const Color(0xFFF5A623),
                  fontWeight: FontWeight.w600,
                )),
          ]),

          const SizedBox(height: 12),

          // ── Empty state card ─────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                ColorDot(C.flagSaffron),
                SizedBox(width: 5),
                ColorDot(C.flagWhite),
                SizedBox(width: 5),
                ColorDot(C.flagGreen),
              ]),
              const SizedBox(height: 16),
              Container(
                width: 64, height: 64,
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

          const SizedBox(height: 20),

          // ══════════════════════════════════════════════════════════════════
          // AD SPACE — reserved slot for future banner ads
          // Replace the child with your AdWidget / AdMob banner when ready.
          // ══════════════════════════════════════════════════════════════════
          Container(
            width: double.infinity,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFDDDDDD),
                // dashed effect via strokeAlign isn't native; use a solid
                // light border as placeholder
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.campaign_outlined,
                    color: Color(0xFFCCCCCC), size: 20),
                const SizedBox(width: 8),
                Text(
                  'Ad space · 320 × 50',
                  style: TextStyle(
                    fontSize: sp(ctx, 11),
                    color: const Color(0xFFCCCCCC),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat card
// ─────────────────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color? valueColor;

  const _StatCard({
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(height: 8),
        Text(value,
            style: TextStyle(
              fontSize: sp(ctx, 16),
              fontWeight: FontWeight.w800,
              color: valueColor ?? const Color(0xFF1A1A1A),
            )),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
              fontSize: sp(ctx, 10),
              color: const Color(0xFF999999),
              fontWeight: FontWeight.w500,
            )),
      ]),
    );
  }
}