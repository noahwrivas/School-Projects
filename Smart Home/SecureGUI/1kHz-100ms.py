import subprocess
import time

subprocess.call(['gpio','mode','1','pwmTone'])

startTime = time.clock(); // Minutes on system clock
subprocess.call(['gpio','pwmTone','1','1000'])
while True:
    if time.clock()-startTime > 0.100:
	subprocess.call(['gpio','pwmTone','1','0'])
	break
