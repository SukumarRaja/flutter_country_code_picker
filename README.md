## Flutter Country Code Picker

A flutter package to select a country from a list of countries.

It works on Android, iOS, macOS, linux, windows and web

## Getting Started

Add the package to your pubspec.yaml:

`flutter pub add flutter_contry_code_picker`

in your dart file, import the library
```dart
import 'package:flutter_country_code_picker/flutter_country_code_picker.dart';
```

Show country code picker using IntlPhoneField :

### example

The `country code` widget load the country code with flags

```dart
import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/flutter_country_code_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var number = "";
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // Picker name
            Text("Flutter Country Code Picker"),

            //Picker Widget
            IntlPhoneField(
                maxLength: 10,
                controller: controller,
                initialCountryCode: "IN",
                validator: (data) {
                  return null;
                },
                onChanged: (data) {
                  number = data;
                  print("number is $data");
                }
            )

            //Entered Data
            Text("Entered Number is $number")

          ],
        ),
      ),
    );
  }
}
```


### example `ScreenShots`
This example shows how to take full control over the picker by providing your own build`.
## gif 

![ezgif com-gif-maker](https://user-images.githubusercontent.com/99036793/204272434-db5bab2d-b782-4828-bbf0-e0e06d0959ff.gif)

## images

<img src=![Screenshot_2022-11-28-17-05-16-800_hashseven com customer](https://user-images.githubusercontent.com/99036793/204272531-f525a6cb-3183-4624-bc97-07e75bdb24ee.jpg) width=50,height=50>

![Screenshot_2022-11-28-17-05-21-752_hashseven com customer](https://user-images.githubusercontent.com/99036793/204272538-79a97f6a-8c89-4273-a713-52f5040736ed.jpg)

![Screenshot_2022-11-28-17-05-27-646_hashseven com customer](https://user-images.githubusercontent.com/99036793/204272542-72f0c9f0-6742-4547-87c0-c86b580c9cb1.jpg)

![Screenshot_2022-11-28-17-05-36-320_hashseven com customer](https://user-images.githubusercontent.com/99036793/204272546-936955ac-bbba-410a-a61a-f3a9cedfe998.jpg)


## Flutter pub add

add the package with `flutter pub add flutter_contry_code_picker`




    
