import subprocess
import time

subprocess.call(['gpio','mode','1','pwmTone'])

startTime = time.time();
subprocess.call(['gpio','pwmTone','1','1000'])
while True:
    if time.time()-startTime > 0.25:
	subprocess.call(['gpio','pwmTone','1','0'])
	break
