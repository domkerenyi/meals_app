// this is the blueprint for the categories we will have
import 'package:flutter/material.dart';


class Category {
    const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, // default color if not provided
  });
  
  final String id;
  final String title;
  final Color color;
}