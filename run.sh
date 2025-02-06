#!/bin/bash
export LOCALAPPDATA="LOCALAPPDATA"
screen -L -Logfile python_script.log -S python_script -d -m bash -c "python3 /home/indowings-kinetic/Final_KS/function.py"
