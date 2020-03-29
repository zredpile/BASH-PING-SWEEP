#!/bin/bash
echo "-- UNIQUE VISITORS ADDRESSES : "
echo
cat  access_log | cut -d " " -f 1| sort -u 
echo
echo
echo "-- WHO VISTED robots.txt :"
echo
cat access_log | grep "robots.txt"| cut -d " " -f 1 |sort -u
