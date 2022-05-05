import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget(this.message, this.username, this.isMe, {this.key})
      : super(key: key);

  final Key? key;
  final String message;
  final String username;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14),
              topRight: const Radius.circular(14),
              bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(14),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(14),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: isMe ? 60 : 8,
            right: isMe ? 8 : 60,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).colorScheme.onBackground,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              )
            ],
          ),
        ),
      ],
    );
  }
}
