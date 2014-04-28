import os, sys

def exeCmd(cmd):
	return os.popen(cmd).readlines()
	
def findPortHostPid(port):
	cmd = "netstat -ano |findstr " + str(port)
	info = exeCmd(cmd)
	pids = []
	for line in info:
		data = line.split(" ")
		pids.append(int(data[-1]))
	return pids	
	
def findAppNameByPids(pids):	
	rcmd = "tasklist | findstr "
	for pid in pids:
		if (pid != 0):
			ptr = exeCmd(rcmd + str(pid))
			print ptr[:4]

def findAdbPortPids():
	pids = findPortHostPid(5037)
	print "occupied adb port app name is:"
	findAppNameByPids(set(pids))
	
findAdbPortPids()
while(True):		
	kpid = int(raw_input("input -1 to exit or input killed pid: "))
	if (kpid == -1) :
		break
	kcmd = "taskkill /f /pid "
	exeCmd(kcmd + str(kpid))
	findAdbPortPids()
