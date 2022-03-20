# vhdl-hdmi-output-example-vivado-arty-z7
I couldn't get the HDMI examples for the Digilent Arty Z7 20 running, so I wrote my own. This example just produces a single frame.

## Introduction
I built this in order to try the HDMI output of my Digilent Arty Z7 20 board. Also, because I wanted to try Vivado version control with Git. I hope it works. If there are any problems with building the project, please message me.

![image](https://user-images.githubusercontent.com/9955664/159184366-bbd6c1af-cc93-4db5-a4cb-837d844929e2.png)

## Requisites
- Digilent Arty Z7 20 Development board; connected to you PC via USB and to a TV via HDMI
- Vivado 2021.2

## How to build
1. Clone/Download/Unzip repository.
2. Open Vivado
3. Tools - Run Tcl Script... - open the build.tcl script in the origin of this repository.
4. Synthesize, Implement, Generate Bitstream, Program Device...
5. Enjoy a yellow-green-ish screen in 640x480 :)

## Additional Libraries
I used some of the Digilent video libraries that are provided in the Digilent repository on Github.
