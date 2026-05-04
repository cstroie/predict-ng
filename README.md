# predict-ng

**predict-ng** is a modernized continuation of John Magliacane's (KD2BD) classic
PREDICT satellite tracking and orbital prediction program.

## Features

- Real-time single and multi-satellite tracking (24 satellites)
- Orbital pass prediction (visual and radio)
- Solar and lunar position tracking
- SGP4/SDP4 orbital models
- UDP socket server for client applications
- Serial port antenna rotator control (EasyComm 2)
- Optional voice announcements (vocalizer)
- Automatic TLE update via `kepupdate`

## Build

```
./configure [--prefix=DIR] [--enable-vocalizer]
make
sudo make install
```

Default install prefix is `/usr/local`. The vocalizer (voice announcements)
requires `/dev/dsp` and is disabled by default.

## First Time Use

On first run, predict-ng will prompt for your ground station location.
Longitude is entered in decimal degrees **East** (negative for West).
Latitude in decimal degrees North (negative for South).

Run `kepupdate` to fetch current TLE data from Celestrak.

## Files

- `~/.predict/predict.tle` — Keplerian orbital data (up to 24 satellites)
- `~/.predict/predict.db` — Transponder database
- `~/.predict/predict.qth` — Ground station location

## Authors

See [AUTHORS](AUTHORS) for the full list of contributors.

## License

GNU General Public License, version 2 or later.
