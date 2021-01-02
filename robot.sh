#!/bin/bash

cd src
robot --listener "allure_robotframework;../Logs/allure/logs" -d ../Logs/robot -P ../Libraries -v RESOURCES:../Resources ./*.robot $1 $2 $3 $4 $5 $6 $7 $8 $9
allure generate --clean ../Logs/allure/logs -o ../Logs/allure/report
