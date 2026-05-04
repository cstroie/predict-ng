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

## Documentation

See `man predict` after installation, or `docs/man/predict.man` in the source tree.

## Authors

See [AUTHORS](AUTHORS) for the full list of contributors.

## License

GNU General Public License, version 2 or later. See the source code for details.
