import XCTest
@testable import KoTextCountLimit

final class KoTextCountLimitTests: XCTestCase {
    
    var textCountLimit: KoTextCountLimit!
    
    override func setUp() {
        super.setUp()
        textCountLimit = KoTextCountLimit()
    }
    
    override func tearDown() {
        textCountLimit = nil
        super.tearDown()
    }
    
    func testShouldChangeTextWithinLimit() {
        let textField = UITextField()
        textField.text = "Hello"
        
        let shouldChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 5, length: 0),
                                                           replacementText: "W", maxCharacterLimit: 10)
        
        XCTAssertTrue(shouldChange, "텍스트 변경 제한 범위 내에서 허용")
    }
    
    func testShouldNotChangeTextExceedingLimit() {
        let textField = UITextField()
        textField.text = "HelloWorld"
        
        let shouldChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 10, length: 0),
                                                           replacementText: "!", maxCharacterLimit: 10)
        
        XCTAssertFalse(shouldChange, "텍스트(한글) 제한 범위 초과하여 변경을 허용하지 않아야함")
    }
    
    func testShouldHandleBackspaceCorrectly() {
        let textField = UITextField()
        textField.text = "Hello"
        
        let shouldChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 5, length: 1),
                                                           replacementText: "", maxCharacterLimit: 10)
        
        XCTAssertTrue(shouldChange, "백스페이스 처리해야함")
    }
    
    func testShouldHandleKoreanCharacterLimit() {
        let textField = UITextField()
        textField.text = "안녕하세요"
        
        let shouldChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 5, length: 0),
                                                           replacementText: "세", maxCharacterLimit: 6)
        
        XCTAssertTrue(shouldChange, "제한 내에 한글을 올바르게 처리해야함")
        
        let shouldNotChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 6, length: 0),
                                                              replacementText: "요", maxCharacterLimit: 6)
        XCTAssertFalse(shouldNotChange, "제한을 초과하면 한글을 사용할 수 없음")
    }
    
    func testShouldHandleKoreanBackspaceCorrectly() {
        let textField = UITextField()
        textField.text = "안녕하세요"
        
        let shouldChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 5, length: 1),
                                                           replacementText: "", maxCharacterLimit: 10)
        
        XCTAssertTrue(shouldChange, "한글을 백스페이스를 올바르게 처리해야함")
    }
    
    
    func testShouldNotAllowConsonantExceedingLimit() {
        let textField = UITextField()
        textField.text = "ㅇㅇㅇㅇㅇㅇ"
//        textField.text = "ㅐㅐㅐㅐㅐㅐ"

        // 현재 글자 수는 5글자. 제한은 6글자.
        // 자음만 입력했을 때 제한을 넘는지 확인
        let shouldChange = textCountLimit.shouldChangeText(for: textField, in: NSRange(location: 5, length: 0),
                                                           replacementText: "ㄱ", maxCharacterLimit: 6)
        
        XCTAssertFalse(shouldChange, "글자 수 제한을 초과했을 때 자음 입력을 허용하지 않아야 함")
//        XCTAssertTrue(shouldChange, "글자 수 제한을 초과했을 때 자음 입력을 허용하지 않아야 함")
    }
    
    
}
