# Squatting Monk's Dialogs System

This package contains scripts for my dynamic dialogs system. This system is in 
heavy development and will change a lot before it is done. This is simply an 
initial proof of concept and should not be used by anyone for anything other 
than a demo. You have been warned.

## Prerequisites
- [nwnsc](https://gitlab.com/glorwinger/nwnsc)
- [nwn-lib](https://github.com/niv/nwn-lib)
- [nwn-packer](https://github.com/squattingmonk/nwn-packer)

## Installation
Get the code:
```
git clone https://github.com/squattingmonk/sm-dialogs
git clone https://github.com/squattingmonk/sm-dialogs
```

Run the build script:
```
cd sm-dialogs
rake install
```

The erf will be placed into your Neverwinter Nights install directory in the
`erf` folder. From there you can use the toolset to import it into your module.

Alternatively, you may build the demo module by running the following:
```
cd sm-dialogs
rake demo:install
```

The module will be placed into your Neverwinter Nights install directory in the
`mod` folder.
