# KoTextCountLimit

<p align="center">
  <a href="https://www.swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-compatible-green" /></a>
  <a href="https://opensource.org/licenses/MIT/"><img src="https://img.shields.io/badge/License-MIT-green.svg" /></a>
</p>
<p align="center">
  <a href="https://getstream.io/video/docs/sdk/ios/"><img src="https://img.shields.io/badge/platforms-iOS 13%2B-lightblue" /></a>
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-5.10%2B-orange.svg" /></a>
</p>

KoTextCountLimit is a library designed to address issues that arise when applying character limits to UITextView and UITextField with Korean input. It ensures that character limits are enforced correctly, even with the unique characteristics of the Korean language.

<p align="center">
<img src="https://github.com/user-attachments/assets/9fb581e9-ddef-470c-84fe-2e24dd536544" align="center" width="32%">  
</p>

## Features
- Resolves issues where the final character's consonant, vowel, or backspace is not properly registered when enforcing character limits in Korean input.

## Supported Versions
- Swift 5.10
- iOS 13+

## Swift Package Manager
### Using Swift Package Manager
1. In Xcode, select File > Swift Packages > Add Package Dependency.
2. Enter the project's GitHub URL: https://github.com/iOS-Ruel/KoTextCountLimit.git.
3. Choose the version or branch you want to install, then click Next.
4. Click Finish to complete the installation.

### Manual Installation
1. Clone or download this repository.
2. Drag and drop the KoTextCountLimit folder into your project in Xcode.
3. Select Copy items if needed and click Finish.

## Example
- Usage with UITextView
    - You can use it like this with UITextView. The same approach applies to UITextField.
### Usage

1. Create an instance of `KoTextCountLimit()`.
2. Call the `shouldChangeText(for:in:replacementText:maxCharacterLimit) method`.

```Swift

class ViewController: UIViewController { 
    let textLimit = KoTextCountLimit()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, 
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return textLimit.shouldChangeText(for: textView, 
                                          in: range,
                                          replacementText: text,
                                          maxCharacterLimit: 10)
    }
}
/*
 func shouldChangeText(for textInput: UITextInput, 
                                 in range: NSRange,
                                 replacementText text: String,
                                 maxCharacterLimit: Int) -> Bool
*/
```


## Contributing
### How to Contribute
1. Fork this repository.
2. Create a new feature branch (`git checkout -b feat/featName`).
3. Commit your changes (`git commit -m 'Add some featName'`).
4. Push to the branch (`git push origin feat/featName`).
5. Open a Pull Request.

- Contributions are always welcome to this open-source project 🤗

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.