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
