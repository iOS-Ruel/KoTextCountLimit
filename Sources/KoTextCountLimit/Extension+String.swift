//
//  File.swift
//  
//
//  Created by Chung Wussup on 9/12/24.
//

import Foundation

extension String {
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
