import XCTest
@testable import TypewriterText

final class TypewriterTextTests: XCTestCase {
    func testValidSpeedIsPreserved() {
        XCTAssertEqual(
            TypewriterConfiguration.normalizedSpeed(0.08),
            0.08,
            accuracy: 0.0001
        )
    }

    func testZeroSpeedIsClamped() {
        XCTAssertEqual(
            TypewriterConfiguration.normalizedSpeed(0),
            TypewriterConfiguration.minimumSpeed,
            accuracy: 0.0001
        )
    }

    func testNegativeSpeedIsClamped() {
        XCTAssertEqual(
            TypewriterConfiguration.normalizedSpeed(-1),
            TypewriterConfiguration.minimumSpeed,
            accuracy: 0.0001
        )
    }

    func testInfiniteSpeedUsesFallback() {
        XCTAssertEqual(
            TypewriterConfiguration.normalizedSpeed(.infinity),
            TypewriterConfiguration.fallbackSpeed,
            accuracy: 0.0001
        )
    }

    func testNaNSpeedUsesFallback() {
        XCTAssertEqual(
            TypewriterConfiguration.normalizedSpeed(.nan),
            TypewriterConfiguration.fallbackSpeed,
            accuracy: 0.0001
        )
    }
}
