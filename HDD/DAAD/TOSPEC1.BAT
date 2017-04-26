@echo off
delete cinta.bak
copy cinta.tap cinta.bak
delete cinta.tap
copy tospec1.ta_ cinta.tap
tapmaker %1 cinta.tap 33792
tapmaker tospec1.tb_ cinta.tap 63447
