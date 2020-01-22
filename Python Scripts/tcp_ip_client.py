# -*- coding: utf-8 -*-
"""
Created on Thu Nov 21 21:55:41 2019

@author: lukes
"""

import socket
import sys
import struct
import matplotlib

from matplotlib import pyplot as plt

TCP_IP = '192.168.137.1' # this IP of my pc. When I want raspberry pi 2`s as a server, I replace it with its IP '169.254.54.195'
TCP_PORT = 10000
BUFFER_SIZE = 20 # Normally 1024, but I want fast response
# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect the socket to the port where the server is listening
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
#sock.connect((TCP_IP, TCP_PORT))
sock.connect(('127.0.0.1', 6000))
#for i in range(256):
#    data = sock.recv(1024)
#    floats = struct.unpack('256f', data)
#    print(floats)
for i in range(100):
    data = sock.recv(2048)
    floats = struct.unpack('512f', data)
    plt.plot(floats)
    plt.show()