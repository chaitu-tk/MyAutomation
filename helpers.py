#!/usr/bin/env python
import shlex, subprocess

def runCmd(cmd, timeout = None):

    #print (shlex.split(cmd))
    print (cmd)
    subProcess = subprocess.Popen(cmd)
    #subProcess = subprocess.Popen(shlex.split(cmd))

    out = err = timeout_flag = None

    if (timeout == None):
        (out, err) = subProcess.communicate()
    else:
        start_t = time.time()
        while (subProcess.poll() == None):
            span_t = time.time() - start_t
            if (span_t > timeout):
                subProcess.terminate()
                while (subProcess.poll() == None):
                    time.sleep(0.5)
                (out, err) = subProcess.communicate()
                print ("Timeout for command: %s" % cmd)
                timeout_flag = True

    return (out, err, subProcess.returncode, timeout_flag)

def runSSH(host, user, cmd):
    cmd = "ssh %s@%s \'%s\'" %(user, host, cmd)
    return runCmd(cmd)

runSSH("192.168.100.122", "test", r"ps aux | grep -v grep | grep -i track | tail -1 | awk \'{print $2}\' ")
