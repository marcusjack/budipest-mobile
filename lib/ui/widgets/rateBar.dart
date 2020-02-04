import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/ToiletModel.dart';
import '../../core/viewmodels/UserModel.dart';
import '../../core/models/toilet.dart';
import '../../core/services/api.dart';
import '../../locator.dart';
import './button.dart';

class RateBar extends StatefulWidget {
  RateBar(this.toilet, this._api);
  Toilet toilet;
  API _api;
  int myVote;

  @override
  _RateBarState createState() => _RateBarState();
}

class _RateBarState extends State<RateBar> {
  void vote(
      String userId, ToiletModel toiletProvider, Toilet toilet, bool isUpvote) {
    switch (widget.myVote) {
      // i had an upvote
      case 1:
        {
          if (isUpvote) {
            // and i want to remove upvote
            // toilet.upvotes -= 1;
          } else {
            // and i want to downvote
            // toilet.upvotes -= 1;
            // toilet.downvotes += 1;
          }
          setState(() {
            widget.myVote = isUpvote ? 0 : -1;
          });
          break;
        }
      // i didn't have a vote
      case 0:
        {
          // isUpvote ? toilet.upvotes += 1 : toilet.downvotes += 1;
          setState(() {
            widget.myVote = isUpvote ? 1 : -1;
          });
          break;
        }
      // i had a downvote
      case -1:
        {
          // and i want to upvote
          if (isUpvote) {
            // toilet.upvotes += 1;
            // toilet.downvotes -= 1;
          } else {
            // and i want remove downvote
            // toilet.downvotes -= 1;
          }
          setState(() {
            widget.myVote = isUpvote ? 1 : 0;
          });
          break;
        }
    }

    castVote(toiletProvider, widget.myVote);
  }

  void castVote(ToiletModel toiletProvider, int vote) async {
    Map<String, dynamic> votes = widget.toilet.votes;
    votes["votes"] = vote;
    widget._api.updateDocument(votes, widget.toilet.id);
  }

  @override
  Widget build(BuildContext context) {
    final toiletProvider = Provider.of<ToiletModel>(context);
    final String userId = locator<UserModel>().userId;
    // widget.myVote = snapshot.data.getInt(widget.toilet.id) ?? 0;

    return Row(
      children: <Widget>[
        Text(
          FlutterI18n.translate(context, "rate"),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Button(
            // widget.toilet.upvotes.toString(),
            "aaa",
            () => vote(
              userId,
              toiletProvider,
              widget.toilet,
              true,
            ),
            icon: Icons.thumb_up,
            backgroundColor:
                widget.myVote == 1 ? Colors.black : Colors.grey[600],
            foregroundColor: Colors.white,
            isMini: true,
          ),
        ),
        Button(
          // widget.toilet.downvotes.toString(),
          "aaa",
          () => vote(
            userId,
            toiletProvider,
            widget.toilet,
            false,
          ),
          icon: Icons.thumb_down,
          backgroundColor:
              widget.myVote == -1 ? Colors.black : Colors.grey[600],
          foregroundColor: Colors.white,
          isMini: true,
        ),
      ],
    );
  }
}
