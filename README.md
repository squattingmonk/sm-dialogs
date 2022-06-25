# Squatting Monk's Dynamic Dialogs System

This package contains scripts for my dynamic dialogs system. This system is in
heavy development and will change a lot before it is done. This is simply an
initial proof of concept and should not be used by anyone for anything other
than a demo. You have been warned.

## Prerequisites
- [nwnsc](https://github.com/nwneetools/nwnsc)
- [nasher](https://github.com/squattingmonk/nasher) >= 0.18.2
- [sm-utils](https://github.com/squattingmonk/sm-utils)

## Installation
Get the code:
```
git clone https://github.com/squattingmonk/sm-utils
git clone https://github.com/squattingmonk/sm-dialogs
```

Run the build script:
```
cd sm-dialogs
nasher install
```

This will create the `erf/sm_dialogs.erf` file in your Neverwinter Nights
install directory. Import this into a new or existing module.

## Acknowledgements
This system is heavily based on Acaos's HG Dialog system and Greyhawk0's
ZZ-Dialog, which is itself based on pspeed's Z-dialog.
