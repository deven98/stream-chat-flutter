import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/src/back_button.dart';
import 'package:stream_chat_flutter/src/stream_chat_theme.dart';

/// ![screenshot](https://raw.githubusercontent.com/GetStream/stream-chat-flutter/master/screenshots/thread_header.png)
/// ![screenshot](https://raw.githubusercontent.com/GetStream/stream-chat-flutter/master/screenshots/thread_header_paint.png)
///
/// It shows the current thread information.
///
/// ```dart
/// class ThreadPage extends StatelessWidget {
///   final Message parent;
///
///   ThreadPage({
///     Key key,
///     this.parent,
///   }) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: ThreadHeader(
///         parent: parent,
///       ),
///       body: Column(
///         children: <Widget>[
///           Expanded(
///             child: MessageListView(
///               parentMessage: parent,
///             ),
///           ),
///           MessageInput(
///             parentMessage: parent,
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
///
/// Usually you would use this widget as an [AppBar] inside a [Scaffold].
/// However you can also use it as a normal widget.
///
/// Make sure to have a [StreamChannel] ancestor in order to provide the information about the channel.
/// Every part of the widget uses a [StreamBuilder] to render the channel information as soon as it updates.
///
/// By default the widget shows a backButton that calls [Navigator.pop].
/// You can disable this button using the [showBackButton] property of just override the behaviour
/// with [onBackPressed].
///
/// The widget components render the ui based on the first ancestor of type [StreamChatTheme] and on its [ChannelTheme.channelHeaderTheme] property.
/// Modify it to change the widget appearance.
class ThreadHeader extends StatelessWidget implements PreferredSizeWidget {
  /// True if this header shows the leading back button
  final bool showBackButton;

  /// Callback to call when pressing the back button.
  /// By default it calls [Navigator.pop]
  final VoidCallback onBackPressed;

  /// The message parent of this thread
  final Message parent;

  /// Instantiate a new ThreadHeader
  ThreadHeader({
    Key key,
    @required this.parent,
    this.showBackButton = true,
    this.onBackPressed,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      backgroundColor:
          StreamChatTheme.of(context).channelTheme.channelHeaderTheme.color,
      actions: <Widget>[
        Container(
          child: showBackButton
              ? StreamBackButton(
                  onPressed: onBackPressed,
                  icon: Icons.close,
                )
              : SizedBox(),
        ),
      ],
      centerTitle: false,
      title: Text.rich(
        TextSpan(
          text: 'Thread',
          children: [
            TextSpan(
              text:
                  '   ${parent.replyCount} ${parent.replyCount == 1 ? 'reply' : 'replies'}',
              style: StreamChatTheme.of(context)
                  .channelTheme
                  .channelHeaderTheme
                  .lastMessageAt,
            ),
          ],
        ),
        style:
            StreamChatTheme.of(context).channelTheme.channelHeaderTheme.title,
      ),
    );
  }

  @override
  final Size preferredSize;
}
