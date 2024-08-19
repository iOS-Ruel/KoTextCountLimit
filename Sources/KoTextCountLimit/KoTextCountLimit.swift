// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class KoTextCountLimit {
    public init() {}
    
    public func shouldChangeText(for textInput: UITextInput,
                                 in range: NSRange,
                                 replacementText text: String,
                                 maxCharacterLimit: Int) -> Bool {
        if text.isBackspace {
            return true
        }
        
        let currentText = (textInput as? UITextView)?.text ?? (textInput as? UITextField)?.text ?? ""
        
        if currentText.count >= maxCharacterLimit {
            return canAddText(currentText: currentText,
                              replacementText: text,
                              maxCharacterLimit: maxCharacterLimit)
        }
        
        return true
    }
    
    private func canAddText(currentText: String, replacementText text: String, maxCharacterLimit: Int) -> Bool {
        let hasPostPosition = currentText.hasPostPosition
        let isConsonantChar = text.isConsonant
        let isVowelChar = text.isVowel
        
        if !hasPostPosition && isConsonantChar {
            return currentText.utf16.count + text.count <= maxCharacterLimit || !isVowelChar
        } else if hasPostPosition && !isConsonantChar {
            if let lastText = currentText.last, lastText.isConsonant {
                return true
            } else {
                return currentText.count > maxCharacterLimit ? isVowelChar : false
            }
        } else {
            return false
        }
    }
}

private extension String {
    var isBackspace: Bool {
        return cString(using: .utf8) == nil ? false : strcmp(cString(using: .utf8)!, "\\b") == -92
    }
    
    var hasPostPosition: Bool {
        guard let lastText = self.last else { return false }
        guard let unicodeVal = UnicodeScalar(String(lastText))?.value,
                0xAC00...0xD7A3 ~= unicodeVal else {
            return false
        }
        let last = (unicodeVal - 0xAC00) % 28
        return last > 0
    }
    
    var isConsonant: Bool {
        guard let firstScalar = unicodeScalars.first?.value else { return false }
        return 0x3131...0x314E ~= firstScalar
    }
    
    var isVowel: Bool {
        guard let firstScalar = unicodeScalars.first?.value else { return false }
        return (0x314F...0x3163 ~= firstScalar) || firstScalar == 0x318D
    }
}

private extension Character {
    var isConsonant: Bool {
        return String(self).isConsonant
    }
}
