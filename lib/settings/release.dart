import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ReleaseNotesWidget extends StatelessWidget {

  final String releaseNotes;

  ReleaseNotesWidget(this.releaseNotes);

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18N.of(context).releaseNotes)
      ),
      body: Markdown(
        selectable: false,
        data: releaseNotes,
      )
    );
  }
}


class CreditsWidget extends StatelessWidget {

  final String credits;

  CreditsWidget(this.credits);

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18N.of(context).credits),
      ),
      body: Markdown(
        selectable: false,
        data: credits
      )
    );
  }
}