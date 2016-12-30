# hashcash-cli

Command line app to create and validate Hashcash time stamps

## Building

```swift build```

## Usage

```
$ .build/debug/hashcash-cli

Missing required options: ["-o, --operation", "-b, --bits"]

Usage: .build/debug/hashcash-cli [options]
  -o, --operation:
      Hashcash operation - `create` or `validate`.
  -b, --bits:
      Required collision bits.
  -r, --resource:
      Resource string for `create` (required) and stamp for `validate` (optional).
  -s, --stamp:
      Stamp to validate.
  -t, --timestamp:
      Check a timestamp for validity.
```
