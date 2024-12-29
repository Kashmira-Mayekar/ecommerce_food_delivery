import 'package:ecommerce_food_delivery/utils/constants/number_constants.dart';
import 'package:ecommerce_food_delivery/utils/constants/string_constants.dart';
import 'package:ecommerce_food_delivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.isAutoComplete =
        false, // Flag to toggle between autocomplete and normal text field
    this.autoCompleteOptions = const [],
    this.onSelectedOption,
    int? maxLength,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.isReadOnly = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.onTapOutside,
    this.inputFormatters,
    this.height,
    this.counterText,
    this.textAlign,
    String? initialValue,
    this.minLines,
    this.readOnly,
  })  : maxLength = maxLength,
        super(key: key);

  final bool isAutoComplete;
  final List<String> autoCompleteOptions;
  final Function(String)? onSelectedOption;
  final int? maxLength;
  final MaxLengthEnforcement maxLengthEnforcement;
  final Alignment? alignment;
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextStyle? textStyle;
  final bool obscureText;
  final bool isReadOnly;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final TextAlign? textAlign;
  final Color? fillColor;
  final bool? filled;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final String? counterText;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: isAutoComplete == Str.isTrue
                ? autoCompleteWidgetAsDialog(context)
                : textFormFieldWidget(context),
          )
        : isAutoComplete == Str.isTrue
            ? autoCompleteWidgetAsDialog(context)
            : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        height: height,
        child: TextFormField(
          cursorHeight: NumberConstants.d12,
          onChanged: onChanged,
          onTapOutside: (value) => hideKeyboard(),
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          onTap: onTap,
          minLines: minLines,
          focusNode: focusNode,
          autofocus: autofocus,
          style: textStyle ?? TextStyle(fontSize: 12),
          obscureText: obscureText,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          decoration: decoration,
          validator: validator,
          inputFormatters: inputFormatters,
          readOnly: readOnly ?? false,
          textAlign: textAlign ?? TextAlign.left,
          onFieldSubmitted: onFieldSubmitted,
        ),
      );

  Widget autoCompleteWidgetAsDialog(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Open the search dialog
        final String? selectedValue = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return SearchDialog(
              height: height,
              width: width,
              options: autoCompleteOptions,
              initialValue: controller?.text ?? '',
              onSelected: (String value) {
                controller?.text =
                    value; // Update the text field with the selected value
                if (onSelectedOption != null) {
                  onSelectedOption!(value);
                }
              },
            );
          },
        );

        if (selectedValue != null) {
          controller?.text = selectedValue;
        }
      },
      child: AbsorbPointer(
        child: textFormFieldWidget(context),
      ),
    );
  }

  Widget autoCompleteWidget(BuildContext context) => Container(
        width: width ?? double.maxFinite,
        height: height,
        child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (autoCompleteOptions.isEmpty || textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return autoCompleteOptions.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            controller?.text = selection;
            if (onSelectedOption != null) {
              onSelectedOption!(selection);
            }
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
            return Material(
              elevation: 4,
              child: SizedBox(
                width: width ?? double.maxFinite,
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.elementAt(index);
                    return ListTile(
                      title: Text(
                        option,
                        style: TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        onSelected(option);
                      },
                    );
                  },
                ),
              ),
            );
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            return TextFormField(
              cursorHeight: NumberConstants.d12,
              controller: textEditingController,
              focusNode: fieldFocusNode,
              decoration: decoration,
              style: textStyle ?? TextStyle(fontSize: 12),
              onFieldSubmitted: (value) {
                onFieldSubmitted();
                if (onFieldSubmitted != null) {
                  onFieldSubmitted();
                }
              },
            );
          },
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? Str.emptyString,
        counterText: counterText,
        counterStyle: TextStyle(color: Colors.grey, fontSize: 12),
        hintStyle: hintStyle ?? TextStyle(fontSize: 12, color: Colors.grey),
        labelText: labelText ?? Str.emptyString,
        labelStyle:
            textStyle ?? TextStyle(fontSize: 12, color: Colors.grey.shade800),
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: Str.isFalse,
        contentPadding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        fillColor: fillColor ?? Colors.white54,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(2)),
        errorStyle: TextStyle(color: Colors.red),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(2)),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(2)),
      );
}

class SearchDialog extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final Function(String) onSelected;
  final double? height;
  final double? width;

  const SearchDialog({
    Key? key,
    required this.options,
    required this.initialValue,
    required this.onSelected,
    this.height, // Add height
    this.width, // Add width
  }) : super(key: key);

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late TextEditingController _searchController;
  late List<String> _filteredOptions;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialValue);
    _filteredOptions = widget.options;

    _searchController.addListener(() {
      setState(() {
        _filteredOptions = widget.options
            .where((option) => option
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 400, // Use default if height is not passed
        width: 400, // Use default if width is not passed
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredOptions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _filteredOptions[index],
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () {
                      widget.onSelected(_filteredOptions[index]);
                      Navigator.of(context).pop(_filteredOptions[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
