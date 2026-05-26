import 'package:flutter/material.dart';
import 'package:barabar/src/theme.dart';
import 'package:barabar/src/utils.dart';
import 'package:barabar/src/widgets/common_widgets.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroupScreen> {
  final _name = TextEditingController();
  String _type = 'Trip';

  static const _types = [
    {'e': '🏠', 'l': 'Flatmates'},
    {'e': '✈️', 'l': 'Trip'},
    {'e': '💼', 'l': 'Office'},
    {'e': '👫', 'l': 'Friends'},
    {'e': '👨‍👩‍👧', 'l': 'Family'},
    {'e': '🎉', 'l': 'Event'},
  ];

  @override
  Widget build(BuildContext ctx) {
    final p = kPad(ctx);

    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(
        backgroundColor: C.card,
        elevation: 0,
        centerTitle: false,
        title: Text('New Group',
            style: TextStyle(
              color: C.textPrimary,
              fontSize: sp(ctx, 16),
              fontWeight: FontWeight.w700,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: C.textSecond, size: 18),
          onPressed: () => Navigator.pop(ctx),
        ),
        bottom: const TricolorBottom(),
      ),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: const [
        AdBanner(),
        Tricolor(h: 2),
      ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(p),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: p * 0.4),
          const FieldLabel('GROUP NAME'),
          const SizedBox(height: 8),
          HKField(
            controller: _name,
            hint: 'e.g. Goa Trip 2025, Office Lunch',
            prefix: Icons.group_outlined,
          ),
          SizedBox(height: p),
          const FieldLabel('GROUP TYPE'),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.3,
            ),
            itemCount: _types.length,
            itemBuilder: (_, i) {
              final t = _types[i];
              final sel = _type == t['l'];
              return GestureDetector(
                onTap: () => setState(() => _type = t['l']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: sel ? C.saffronBg : C.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: sel ? C.saffron : C.border,
                      width: sel ? 1.5 : 1,
                    ),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(t['e']!, style: const TextStyle(fontSize: 14)),
                    const SizedBox(width: 5),
                    Text(t['l']!,
                        style: TextStyle(
                          fontSize: sp(ctx, 11),
                          fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                          color: sel ? C.saffron : C.textSecond,
                        )),
                  ]),
                ),
              );
            },
          ),
          SizedBox(height: p),
          const FieldLabel('STARTING BALANCE (OPTIONAL)'),
          const SizedBox(height: 8),
          const HKField(
            hint: 'e.g. 5000',
            prefix: Icons.currency_rupee_rounded,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: p),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: C.emeraldBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0x3800B96B)),
            ),
            child: Row(children: [
              const Text('💡', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Members settle directly via GPay,\nPhonePe or Paytm with one tap.',
                  style: TextStyle(
                    fontSize: sp(ctx, 12),
                    color: C.emerald,
                    height: 1.4,
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: p * 1.5),
          PrimaryBtn(
            label: 'Create Group',
            icon: Icons.check_rounded,
            onTap: () {
              if (_name.text.trim().isEmpty) {
                showSnack(ctx, 'Please enter a group name', error: true);
                return;
              }
              showSnack(ctx, '${_name.text} created! 🎉 Firebase coming next.');
            },
          ),
          SizedBox(height: p),
        ]),
      ),
    );
  }
}
