import 'package:flutter/material.dart';
import 'package:barabar/src/theme.dart';
import 'package:barabar/src/utils.dart';
import 'package:barabar/src/widgets/common_widgets.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({super.key});

  @override
  State<JoinGroupScreen> createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroupScreen> {
  final _code = TextEditingController();

  @override
  Widget build(BuildContext ctx) {
    final p = kPad(ctx);

    return Scaffold(
      backgroundColor: C.bg,
      appBar: AppBar(
        backgroundColor: C.card,
        elevation: 0,
        centerTitle: false,
        title: Text('Join a Group',
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(p * 1.3),
            decoration: BoxDecoration(
              color: C.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: C.border),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                ColorDot(C.flagSaffron),
                SizedBox(width: 5),
                ColorDot(C.flagWhite),
                SizedBox(width: 5),
                ColorDot(C.flagGreen),
              ]),
              const SizedBox(height: 18),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: C.saffronBg,
                  shape: BoxShape.circle,
                ),
                child: const Center(child: Text('🔗', style: TextStyle(fontSize: 26))),
              ),
              const SizedBox(height: 14),
              Text('Ask your friend for the\n6-digit invite code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: sp(ctx, 15),
                    fontWeight: FontWeight.w700,
                    color: C.textPrimary,
                    height: 1.4,
                  )),
              const SizedBox(height: 5),
              Text(
                'The group creator shares the code\nfrom inside the group',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sp(ctx, 11),
                  color: C.textSecond,
                ),
              ),
            ]),
          ),
          SizedBox(height: p * 1.2),
          const FieldLabel('ENTER INVITE CODE'),
          const SizedBox(height: 10),
          TextField(
            controller: _code,
            textCapitalization: TextCapitalization.characters,
            maxLength: 6,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: C.saffron,
              fontSize: sp(ctx, 32),
              fontWeight: FontWeight.w800,
              letterSpacing: 14,
            ),
            decoration: InputDecoration(
              hintText: '· · · · · ·',
              hintStyle: TextStyle(
                color: C.textHint,
                fontSize: sp(ctx, 26),
                letterSpacing: 10,
              ),
              counterText: '',
              filled: true,
              fillColor: C.card,
              contentPadding: const EdgeInsets.symmetric(vertical: 22),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: C.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: C.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: C.saffron, width: 1.5),
              ),
            ),
          ),
          SizedBox(height: p * 1.5),
          GestureDetector(
            onTap: () {
              if (_code.text.trim().length < 6) {
                showSnack(ctx, 'Please enter the full 6-digit code', error: true);
                return;
              }
              showSnack(ctx, 'Firebase lookup coming next! 🚀');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [C.emerald, Color(0xFF007A44)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [BoxShadow(
                  color: Color(0x4D00B96B),
                  blurRadius: 18,
                  offset: Offset(0, 7),
                )],
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.check_rounded, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text('Join Group',
                    style: TextStyle(
                      fontSize: sp(ctx, 15),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
              ]),
            ),
          ),
          SizedBox(height: p),
        ]),
      ),
    );
  }
}
