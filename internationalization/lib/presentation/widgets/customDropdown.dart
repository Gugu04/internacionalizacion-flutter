import 'package:flutter/material.dart';
import 'package:internationalization/data/preferences/languageConstants.dart';
import 'package:internationalization/data/local/memoryData.dart';
import 'package:internationalization/localization/languageDelegate.dart';
import 'package:internationalization/main.dart';
import 'package:internationalization/model/languageDto.dart';
import 'package:internationalization/painter/trianglePainter.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  OverlayEntry floatingDropdown;
  Locale locale;

  @override
  void initState() {
    actionKey = LabeledGlobalKey('actionKey');
    super.initState();
  }

/*Método para guardar el registro seleccionado y cambiar 
  la variable locale de  la clase MyApp
*/
  void _changeLanguage(LanguageDto language) async {
    Locale _locale =
        await setLocale(language.strLanguageCode, language.strCountryCode);
    MyApp.setLocale(context, _locale);
  }

  void dropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    final offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown(BuildContext context) {
    return OverlayEntry(builder: (context) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              floatingDropdown.remove();
              isDropdownOpened = false;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).shadowColor.withOpacity(0.5),
            ),
          ),
          Positioned(
              top: yPosition - (height - 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  LanguageDelegate.of(context).translate('select'),
                  style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(color: Colors.white, shadows: [
                          Shadow(
                              color: Colors.black,
                              blurRadius: 2.0,
                              offset: Offset(1, 1))
                        ]),
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          Positioned(
              top: yPosition + height,
              width: width,
              child: Column(
                children: <Widget>[
                  CustomPaint(
                    painter: TrianglePainter(),
                    child: Container(
                      height: 25,
                      width: 30,
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    elevation: 10,
                    child: Container(
                        height: 151,
                        width: 130,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: languages()
                              .map((lang) => ListTile(
                                    visualDensity: VisualDensity(vertical: -3),
                                    title: Text(
                                        "${lang.strFlagEmoji}\u{0020}${lang.strLanguage}",
                                        style:
                                            Theme.of(context).textTheme.button),
                                    onTap: () {
                                      _changeLanguage(lang);
                                      setState(() {
                                        if (isDropdownOpened) {
                                          floatingDropdown.remove();
                                        }
                                        isDropdownOpened = !isDropdownOpened;
                                      });
                                    },
                                  ))
                              .toList(),
                        )),
                  ),
                ],
              )),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onPanEnd: (DragEndDetails details) => floatingDropdown.remove(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  LanguageDelegate.of(context).translate('emoji_lenguage'),
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 1,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
          } else {
            dropdownData();
            floatingDropdown = _createFloatingDropdown(context);
            Overlay.of(context).insert(floatingDropdown);
          }

          isDropdownOpened = !isDropdownOpened;
        });
      },
    );
  }
}
