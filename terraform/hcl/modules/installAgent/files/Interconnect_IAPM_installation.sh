#!/bin/sh
set -x
export SKIP_PRECHECK=1
export IGNORE_PRECHECK_WARNING=1
export NOT_REQ_CHECK_ID=1
export IGNORE_PRECHECK=1

curl https://raw.githubusercontent.com/camc-experimental/interconnect-apm/master/apm_demo.tar.gz

if [ $? -ne 0 ]
then
	exit 5
fi

tar -zxf apm_demo.tar.gz

if [ $? -ne 0 ]
then
	exit 1
fi
cd ./IAPM_Agent_Install_8.1.3.1

if [ $? -ne 0 ]
then
	exit 2
fi
cp ../IAPM_Interconnect_silent_install.txt .

if [ $? -ne 0 ]
then
	exit 3
fi
./installAPMAgents.sh -p IAPM_Interconnect_silent_install.txt

if [ $? -ne 0 ] 
then
	exit 4
else
	exit 0
fi
