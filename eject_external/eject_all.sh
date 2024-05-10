#!/bin/bash

# This script ejects all external drives

osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'