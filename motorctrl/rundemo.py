#!/usr/bin/python

import sys
import os
import subprocess
import argparse
from time import *
from machinekit import launcher

launcher.register_exit_handler()
os.chdir(os.path.dirname(os.path.realpath(__file__)))

parser = argparse.ArgumentParser(description='This is the motorctrl demo run script '
                                 'it demonstrates how a run script could look like '
                                 'and of course starts the motorctrl demo')
parser.add_argument('-c', '--config', help='Starts the config server', action='store_true')
parser.add_argument('-v', '--video', help='Starts the video server', action='store_true')
parser.add_argument('-l', '--local', help='Enable local mode only', action='store_true')
parser.add_argument('-g', '--gladevcp', help='Starts the GladeVCP user interface', action='store_true')
parser.add_argument('-s', '--halscope', help='Starts the halscope', action='store_true')
parser.add_argument('-m', '--halmeter', help='Starts the halmeter', action='store_true')
parser.add_argument('-w', '--webtalk', help='Starts webtalk', action='store_true')
parser.add_argument('-d', '--debug', help='Enable debug mode', action='store_true')

args = parser.parse_args()

if args.debug:
    launcher.set_debug_level(5)

if not args.local:
    # override default $MACHINEKIT_INI with a version which was REMOTE=1
    launcher.set_machinekit_ini('machinekit.ini')

try:
    launcher.check_installation()
    launcher.cleanup_session()
    launcher.load_bbio_file('motorctrl.bbio')
    if args.config:
        # the point-of-contact for QtQUickVCP
        launcher.start_process('configserver -n Motorctrl-Demo .')
    if args.webtalk:
        # the Websockets/JSON bridge into Machinetalk
        launcher.start_process('webtalk --ini motorctrl.ini')
    if args.video:
        launcher.start_process('videoserver --ini video.ini Webcam1')
    launcher.start_realtime()

#    launcher.load_hal_file('hardware.hal',  'hardware.ini')
    command = 'halcmd -i hardware.ini -f hardware.hal'
    subprocess.check_call(command, shell=True)

#    launcher.load_hal_file('hardware.hal',  'motorctrl.ini')

    #launcher.load_hal_file('motorctrl.hal', 'motorctrl.ini')
    command = 'halcmd -i motorctrl.ini -f motorctrl.hal'
    subprocess.check_call(command, shell=True)

    #launcher.load_hal_file('threading.hal', 'motorctrl.ini')
    command = 'halcmd -i motorctrl.ini -f threading.hal'
    subprocess.check_call(command, shell=True)

    if args.gladevcp:
        # start the gladevcp version
        if args.local:
            # no -N flag - local case, use IPC sockets, no zeroconf resolution
            launcher.start_process('gladevcp -E -u motorctrl.py motorctrl.ui')
        else:
            # -N - remote case, use zeroconf resolution
            launcher.start_process('gladevcp -N -E -u motorctrl.py motorctrl.ui')
    if args.halscope:
        # load scope only now - because all sigs are now defined:
        launcher.start_process('halscope')
    if args.halmeter:
        launcher.start_process('halmeter')

except subprocess.CalledProcessError:
    launcher.end_session()
    sys.exit(1)

while True:
    sleep(1)
    launcher.check_processes()
