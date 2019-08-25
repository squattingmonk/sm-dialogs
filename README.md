# Squatting Monk's Dialogs System

This package contains scripts for my dynamic dialogs system. This system is in
heavy development and will change a lot before it is done. This is simply an
initial proof of concept and should not be used by anyone for anything other
than a demo. You have been warned.

## Prerequisites
- [nwnsc](https://gitlab.com/glorwinger/nwnsc)
- [nasher](https://github.com/squattingmonk/nasher.nim)

## Installation
Get the code:
```
git clone https://github.com/squattingmonk/sm-dialogs
```

Run the build script:
```
cd sm-dialogs
nasher install all
```

This will create the following files in your Neverwinter Nights install
directory:
- `modules/sm_dialogs.mod`: a demo module showing the system in action
  (currently a barebones testing ground).
- `erf/sm_dialogs.erf`: an installable erf for use in new or existing
  modules.
