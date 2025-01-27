import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 139, 161, 110));

void main() {
  debugPaintSizeEnabled = false;
  runApp(
    MaterialApp(
      //we must use copyWith because without it, i will have to define all specifications of the themes, but with it, i am using the default things with overriding what i want to costumize
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.secondary,
          foregroundColor:
              kColorScheme.surface, //override the colors of the texts
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          //some themes has different ways to do, like here, we are not using copyWith, instead, i am using styleFrom, which does the same, uses the default values of the styling but gives a chance to override what i want and cosutmize it as i please.
          style:
              ElevatedButton.styleFrom(backgroundColor: kColorScheme.onError),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                //this color (and the theming in general) wont be applied on the largeTitle (in this case its the title in the appBar, why? because the color has been already set above, (foregroundcolor of the appBar) but i can still use this color and theme in other text fields as i did in the title of the cards in the expense_item.dart)
                color: kColorScheme.primary,
              ),
            ),
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(
              //i can override as well the margin from here of the cards
              horizontal: 10,
              vertical: 8),
        ),
      ),
      home: const Expenses(),
    ),
  );
}
