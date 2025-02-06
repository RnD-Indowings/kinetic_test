#!/bin/bash
export LOCALAPPDATA="LOCALAPPDATA"
screen -L -Logfile vehicle_proxy.log -S vehicle_proxy -d -m bash -c "mavproxy.py --force-connected --out=127.0.0.1:14550 --out=127.0.0.1:14569 --daemon"
