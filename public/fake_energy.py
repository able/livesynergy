#!/usr/bin/env python

import sys, socket, select, time, struct, string
import simplejson, urllib2
import pymongo
from pymongo import Connection

connection = Connection('127.0.0.1', 27017)
# connection = Connection('192.168.1.103', 27017)
db = connection['synergy_mobile_beta_development']
energy = db['energies']
x = 1 
power = 100
livePulseIDs = ["A" , "B", "C", "D"]

while True:
    y = 1
    
    for livePulseID in livePulseIDs:
        mongodbReading = {}
        mongodbReading['timestamp'] = time.time()
        mongodbReading['average_power'] = y * power 
        mongodbReading['max_power'] = y * power + 100
        mongodbReading['min_power'] = y * power + 200
        mongodbReading['cumulative_energy'] = y * power + 300
        mongodbReading['apparent_power'] = y * power + 400
        mongodbReading['livePulseID'] = livePulseID 
        mongodbReading['sequence_number'] = x 
        print 'inserting '
        print mongodbReading
        energy.insert(mongodbReading)
        y = y + 1

    x = x + 1 
    power = power + 50
    time.sleep(60) 
