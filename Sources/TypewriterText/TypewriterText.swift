import SwiftUI

/// A lightweight SwiftUI view that reveals text one character at a time.
public struct TypewriterText: View {
    private let text: String
    private let speed: TimeInterval
    private let showsCursor: Bool
    private let cursorCharacter: String
    private let restartToken: Int
    private let onComplete: (() -> Void)?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var displayedText = ""
    @State private var isTyping = false
    @State private var typingTask: Task<Void, Never>?

    public init(
        _ text: String,
        speed: TimeInterval = 0.04,
        showsCursor: Bool = true,
        cursorCharacter: String = "▋",
        restartToken: Int = 0,
        onComplete: (() -> Void)? = nil
    ) {
        self.text = text
        self.speed = TypewriterConfiguration.normalizedSpeed(speed)
        self.showsCursor = showsCursor
        self.cursorCharacter = cursorCharacter
        self.restartToken = restartToken
        self.onComplete = onComplete
    }

    public var body: some View {
        HStack(spacing: 0) {
            Text(displayedText)

            if showsCursor && isTyping {
                Text(cursorCharacter)
                    .accessibilityHidden(true)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(text)
        .onAppear {
            restartAnimation()
        }
        .onChange(of: text) { _ in
            restartAnimation()
        }
        .onChange(of: restartToken) { _ in
            restartAnimation()
        }
        .onChange(of: reduceMotion) { _ in
            restartAnimation()
        }
        .onDisappear {
            typingTask?.cancel()
        }
    }

    private func restartAnimation() {
        typingTask?.cancel()
        typingTask = nil

        guard !text.isEmpty else {
            displayedText = ""
            isTyping = false
            onComplete?()
            return
        }

        if reduceMotion {
            displayedText = text
            isTyping = false
            onComplete?()
            return
        }

        displayedText = ""
        isTyping = true

        let characters = Array(text)

        typingTask = Task { @MainActor in
            for character in characters {
                guard !Task.isCancelled else { return }

                displayedText.append(character)

                do {
                    try await Task.sleep(
                        nanoseconds: UInt64(speed * 1_000_000_000)
                    )
                } catch {
                    return
                }
            }

            guard !Task.isCancelled else { return }

            isTyping = false
            onComplete?()
        }
    }
}

enum TypewriterConfiguration {
    static let minimumSpeed: TimeInterval = 0.005
    static let fallbackSpeed: TimeInterval = 0.04

    static func normalizedSpeed(_ speed: TimeInterval) -> TimeInterval {
        guard speed.isFinite else {
            return fallbackSpeed
        }

        return max(speed, minimumSpeed)
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 24) {
        TypewriterText(
            "Hello, welcome to the app.",
            speed: 0.05
        )

        TypewriterText(
            "This version uses a custom cursor.",
            speed: 0.03,
            cursorCharacter: "_"
        )

        TypewriterText(
            "Cursor disabled.",
            speed: 0.04,
            showsCursor: false
        )
    }
    .padding()
}
