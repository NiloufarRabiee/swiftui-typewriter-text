import SwiftUI
import TypewriterText

struct BasicUsage: View {
    @State private var restartToken = 0
    @State private var status = "Typing..."

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            TypewriterText(
                "A small typewriter animation built with SwiftUI.",
                speed: 0.04,
                showsCursor: true,
                restartToken: restartToken
            ) {
                status = "Finished"
            }

            Text(status)
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Restart") {
                status = "Typing..."
                restartToken += 1
            }
        }
        .padding()
    }
}
