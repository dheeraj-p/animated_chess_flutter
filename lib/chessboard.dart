library chessboard_flutter;

import 'dart:ui' as ui;

import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as chess;

const List<String> files = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

class Chessboard extends StatefulWidget {
  final double size;
  final String fen;

  const Chessboard({this.size, this.fen});

  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<Chessboard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: ChessPainter(chess.Chess.fromFEN(widget.fen)),
      ),
    );
  }
}

class ChessPainter extends CustomPainter {
  final chess.Chess board;

  ChessPainter(this.board);

  Paint _paintToUse(int row, int col) {
    if ((row.isEven && col.isEven) || (row.isOdd && col.isOdd)) {
      return Paint()
        ..color = Colors.green[100]
        ..style = PaintingStyle.fill;
    }
    return Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double singleCellSize = size.width / 8;

    for (int index = 0; index < 64; index++) {
      int row = (index / 8).floor();
      int col = (index % 8);

      String rank = (row - 8).abs().toString();
      String file = files[col];

      chess.Piece piece = board.get(file + rank);

      double top = row * singleCellSize;
      double left = singleCellSize * col;

      Rect rect = Rect.fromLTWH(left, top, singleCellSize, singleCellSize);
      canvas.drawRect(rect, _paintToUse(row, col));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
