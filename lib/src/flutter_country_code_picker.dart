import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../countries.dart';
import '../model/phone.dart';

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;
  final ValueChanged<String>? onChanged;
  final ValueChanged<PhoneNumber>? onCountryChanged;
  final FormFieldValidator<String>? validator;
  final bool autoValidate;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final Brightness keyboardAppearance;
  final String? initialValue;
  final int? maxLength;
  final String? initialCountryCode;
  final List<String>? countries;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool showDropdownIcon;
  final BoxDecoration dropdownDecoration;
  final List<TextInputFormatter>? inputFormatters;
  final String searchText;
  final Color? countryCodeTextColor;
  final Color? dropDownArrowColor;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final Function? onSubmit;

  const IntlPhoneField(
      {Key? key,
      this.initialCountryCode,
      this.obscureText = false,
      this.textAlign = TextAlign.left,
      this.onTap,
      this.readOnly = false,
      this.initialValue,
      this.keyboardType,
      this.autoValidate = true,
      this.controller,
      this.focusNode,
      this.decoration,
      this.style,
      this.onSubmitted,
      this.validator,
      this.onChanged,
      this.countries,
      this.onCountryChanged,
      this.onSaved,
      this.showDropdownIcon = true,
      this.dropdownDecoration = const BoxDecoration(),
      this.inputFormatters,
      this.enabled = true,
      this.keyboardAppearance = Brightness.light,
      this.searchText = 'Search by Country Name',
      this.countryCodeTextColor,
      this.dropDownArrowColor,
      this.autofocus = false,
      this.textInputAction,
      this.maxLength,
      this.onSubmit})
      : super(key: key);

  @override
  State<IntlPhoneField> createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  late List<Map<String, dynamic>> _countryList;
  late Map<String, dynamic> _selectedCountry;
  late List<Map<String, dynamic>> filteredCountries;
  bool empty = false;

  FormFieldValidator<String>? validator;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country['code']))
            .toList();
    filteredCountries = _countryList;
    _selectedCountry = _countryList.firstWhere(
        (item) => item['code'] == (widget.initialCountryCode ?? 'US'),
        orElse: () => _countryList.first);

    validator = widget.autoValidate
        ? ((value) => value != null && value.length != 10
            ? 'Invalid Mobile Number'
            : null)
        : widget.validator;
  }

  Future<void> changeCountry() async {
    empty = false;
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.3),
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ]),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: Colors.red,
                          ),
                        ))
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  focusNode: widget.focusNode,
                  style: const TextStyle(color: Colors.black),
                  textInputAction: widget.textInputAction,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    labelText: widget.searchText,
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCountries = _countryList
                          .where((country) => country['name']!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      if (filteredCountries.isEmpty) {
                        empty = true;
                      } else {
                        empty = false;
                      }
                    });
                  },
                  onSubmitted: (text) =>
                      widget.onSubmit != null ? widget.onSubmit!(text) : null,
                ),
                const SizedBox(height: 20),
                empty == true
                    ? const Text("No Data Found")
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredCountries.length,
                          itemBuilder: (ctx, index) => Column(
                            children: <Widget>[
                              ListTile(
                                leading: Image.asset(
                                  'assets/flags/${filteredCountries[index]['code']!.toLowerCase()}.png',
                                  width: 32,
                                ),
                                title: Text(
                                  filteredCountries[index]['name']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                  '+${filteredCountries[index]['dial_code']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                onTap: () {
                                  setState(() {
                                    _selectedCountry = filteredCountries[index];

                                    if (widget.onCountryChanged != null) {
                                      widget.onCountryChanged!(
                                        PhoneNumber(
                                          countryISOCode:
                                              _selectedCountry['code'],
                                          countryCode:
                                              '+${_selectedCountry['dial_code']}',
                                          number: '',
                                        ),
                                      );
                                    } else {
                                      const Text("No Data Found");
                                    }
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                              const Divider(thickness: 1),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsetsDirectional.only(bottom: 7, top: 5),
        height: 50,
        width: MediaQuery.of(this.context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0),
                  blurRadius: 2,
                  spreadRadius: 2)
            ],
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            buildFlagsButton(),
            Container(
              width: 2,
              height: 48,
              color: Colors.grey.withOpacity(.4),
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: widget.controller,
                obscureText: widget.obscureText,
                maxLength: widget.maxLength,
                validator: widget.validator,
                decoration: const InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.fromLTRB(10, 15, 8, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Phone",
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ));
  }

  DecoratedBox buildFlagsButton() {
    return DecoratedBox(
      decoration: widget.dropdownDecoration,
      child: InkWell(
        borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
        onTap: changeCountry,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.showDropdownIcon
                  ? Icon(
                      Icons.arrow_drop_down,
                      color: widget.dropDownArrowColor,
                    )
                  : const SizedBox(),
              const SizedBox(width: 4),
              Image.asset(
                'assets/flags/${_selectedCountry['code']!.toLowerCase()}.png',
                width: 32,
              ),
              const SizedBox(width: 8),
              FittedBox(
                child: Text(
                  '+${_selectedCountry['dial_code']}',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: widget.countryCodeTextColor),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
