# Note

`note` is a simple note taking app for the terminal using bash. It's for simple fast on the fly note taking, where time spent opening apps is detrimental to catching those thoughts.

## Usage

- Creates an easily viewed and edited markdown file for note storage.

- Notes are time stamped, and titles extracted from the content of the note.

- Notes can be read by `note -r`

## Dependencies

Requires `ed`.

```bash
sudo apt update && sudo apt install ed
```

## Installation

```bash
git clone github.com:jmss127/note.git
```

```bash
cd note
chmod +x note.sh
./note.sh
```

## License

This Project is licensed under the MIT License - see the LICENSE file for details.
