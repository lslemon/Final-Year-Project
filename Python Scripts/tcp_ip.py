# -*- coding: utf-8 -*-
"""
Created on Thu Nov 21 19:54:03 2019

@author: lukes
"""

import socket
import sys
import mne
import matplotlib 
import json
import struct

from matplotlib import pyplot as plt


raw = mne.io.read_raw_gdf('C:/Users/lukes/Downloads/Subject2-[2012.04.07-19.27..02].gdf')
eeg = raw.get_data()
channel1 = eeg[1]
sending = json.dumps(channel1.tolist()).encode()
# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)


HOST = '192.168.137.1'  # Standard loopback interface address (localhost)
PORT = 10000        # Port to listen on (non-privileged ports are > 1023)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind((HOST, PORT))
#sock.bind(('127.0.0.1', 6000))
sock.listen()
conn, addr = sock.accept()

print('Connected by', addr)
with conn:
#    byte_array = struct.pack('512f', *channel1[0:512])
#    conn.sendall(byte_array)
#    conn.close()
    for i in range(100):
        byte_array = struct.pack('512f', *channel1[i*512:(i+1)*512])
        conn.sendall(byte_array)
    conn.close()
