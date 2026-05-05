# predict-ng

**predict-ng** is a modernized continuation of John Magliacane's (KD2BD) classic
PREDICT satellite tracking and orbital prediction program.

## Features

- Real-time single and multi-satellite tracking (up to 24 satellites)
- Orbital pass prediction (visual and radio)
- Solar and lunar position tracking
- SGP4/SDP4 orbital models
- UDP socket server for client applications
- Serial port antenna rotator control (EasyComm 2)
- Optional voice announcements (vocalizer)
- Automatic TLE update via `kepupdate`

## Requirements

- C compiler (gcc or clang)
- ncurses library (`libncurses-dev` or equivalent)
- pthreads and math libraries (standard on Linux)
- `wget` (for `kepupdate`)
- `/dev/dsp` soundcard (optional, for vocalizer)

## Build and Install

```
./configure [--prefix=DIR] [--enable-vocalizer]
make
sudo make install
```

Default install prefix is `/usr/local`. To install elsewhere:

```
./configure --prefix=/usr
```

To build the optional vocalizer (requires `/dev/dsp`):

```
./configure --enable-vocalizer
```

For a full list of options: `./configure --help`

To uninstall:

```
sudo make uninstall
```

## First Time Use

On first run, predict-ng prompts for your ground station location:

- **Latitude** in decimal degrees North (negative for South)
- **Longitude** in decimal degrees East (negative for West)
- **Altitude** in meters above sea level

Then run `kepupdate` to fetch current Keplerian orbital data from Celestrak:

```
kepupdate
```

To automate daily TLE updates, add to your crontab (`crontab -e`):

```
0 2 * * * kepupdate
```

`kepupdate` will also send SIGHUP to any running `predict` instance,
triggering a live reload of the orbital database without restarting.

## Data Files

| File | Description |
|------|-------------|
| `~/.predict/predict.tle` | Keplerian orbital data (up to 24 satellites) |
| `~/.predict/predict.db`  | Satellite transponder database |
| `~/.predict/predict.qth` | Ground station location |

## Command-Line Options

| Option | Description |
|--------|-------------|
| `-P [sat]` | List all passes in the next 24 hours, sorted by AOS. Optional satellite name or catalog number filters to a single satellite. |
| `-p sat [time]` | Predict the next single pass for a satellite from a given Unix start time (default: now). |
| `-f sat start [end]` | Print satellite position(s) at a given time or over a time range. |
| `-dp sat [start [end]]` | Like `-f` but outputs 100 MHz Doppler shift in CSV format. |
| `-u file ...` | Update the orbital database from one or more TLE files, then exit. |
| `-t tlefile` | Use an alternate TLE file. |
| `-q qthfile` | Use an alternate QTH file. |
| `-o file` | Write output to a file instead of stdout. |
| `-e deg` | Set minimum elevation threshold (default 0°). |
| `-s` | Start in UDP server mode (port 1210). |
| `-n port` | Use an alternate UDP port for server mode. |
| `-a port` | Send AZ/EL tracking data to a serial port (EasyComm 2). |
| `-a1 port` | Like `-a` but sends keepalives at least once per second. |

### Examples

List all passes in the next 24 hours:
```
predict -P
```

List only ISS passes in the next 24 hours:
```
predict -P ISS
```

List passes above 10° elevation:
```
predict -P -e 10
```

Predict the next pass for OSCAR-11:
```
predict -p OSCAR-11
```

## Documentation

See `man predict` after installation, or `predict.man` in the source tree.

## Authors

See [AUTHORS](AUTHORS) for the full list of contributors.

## License

GNU General Public License, version 2 or later. See the source code for details.
