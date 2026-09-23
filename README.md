# TypewriterText

A lightweight reusable **SwiftUI typewriter text animation** with configurable speed, optional cursor, restart support, and a completion callback.

It is useful for:

- Onboarding screens
- AI and chat interfaces
- Storytelling
- Tutorial flows
- Intro screens
- Status messages
- Interactive demos

## Features

- Native SwiftUI
- No third-party dependencies
- Character-by-character text animation
- Configurable typing speed
- Optional cursor
- Custom cursor character
- Restart support
- Completion callback
- Reduce Motion support
- Unicode-safe character handling
- iOS and macOS support
- Swift Package Manager support

## Requirements

- iOS 16+
- macOS 13+
- Swift 5.9+

## Installation

### Swift Package Manager

In Xcode:

1. Open your project.
2. Go to **File > Add Package Dependencies...**
3. Enter:

```
https://github.com/NiloufarRabiee/swiftui-typewriter-text
```

4. Add the `TypewriterText` package to your app target.

Then import it:

```swift
import TypewriterText
```

## Basic Usage

```swift
TypewriterText(
    "Hello, welcome to the app.",
    speed: 0.04
)
```

## Hide the Cursor

```swift
TypewriterText(
    "Typing without a cursor.",
    speed: 0.04,
    showsCursor: false
)
```

## Custom Cursor

```swift
TypewriterText(
    "Custom cursor example.",
    speed: 0.03,
    cursorCharacter: "_"
)
```

## Completion Callback

```swift
TypewriterText(
    "This runs a closure when typing finishes."
) {
    print("Finished")
}
```

## Restart the Animation

Change the `restartToken` to replay the animation:

```swift
struct DemoView: View {
    @State private var restartToken = 0

    var body: some View {
        VStack {
            TypewriterText(
                "Replay this text.",
                restartToken: restartToken
            )

            Button("Restart") {
                restartToken += 1
            }
        }
    }
}
```

## Parameters

| Parameter | Description | Default |
|---|---|---|
| `text` | Text to reveal | Required |
| `speed` | Delay between characters in seconds | `0.04` |
| `showsCursor` | Shows a cursor while typing | `true` |
| `cursorCharacter` | Cursor string | `▋` |
| `restartToken` | Changing the value restarts the animation | `0` |
| `onComplete` | Closure called after typing completes | `nil` |

## Accessibility

When **Reduce Motion** is enabled, the full text appears immediately instead of animating character by character.

VoiceOver reads the complete text rather than each partial animation state.

## Unicode Support

The component converts the source string into Swift `Character` values before animating it. This keeps composed characters such as emoji and accented characters intact while revealing the text.

## Example

A complete restart and completion example is included in:

```
Examples/BasicUsage.swift
```

## Testing

Run:

```bash
swift test
```

GitHub Actions CI is included.

## Contributing

Contributions and improvements are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is available under the MIT License.

See [LICENSE](LICENSE).

---

Created by **Niloufar Rabiee**
