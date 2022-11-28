Flutter Country Code Picker

A flutter package to select a country from a list of countries.


##Getting Started

Add the package to your pubspec.yaml:

flutter_country_code_picker: 0.0.1

in your dart file, import the library

import 'package:flutter_country_code_picker';

Show country code picker using IntlPhoneField :

##example
IntlPhoneField(
    maxLength: 10,
    controller: controller,
    initialCountryCode: "IN",
    validator: (data) {
        return null;
    },
    onChanged: (data){
        print("number is $data");
    }
    )


    