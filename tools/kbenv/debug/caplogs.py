import shlex
import subprocess

#    shell_cmd = 'python3 ./subprogram2.py'
#shell_cmd = 'docker events --format "Type={{.Type}}: From={{.From}} Action={{.Action}} ID={{.ID}} Status={{.Status}}"'
shell_cmd = 'docker events'
cmd = shlex.split(shell_cmd)

def _prepare_fold():
    print()

def _start_capture_log(fold_name, docker_id):
    print("    Save to %s/%s, Starting..."%(fold_name,docker_id))

def _stop_capture_log(fold_name, docker_id):
    print("    Save to %s/%s, Stoping..."%(fold_name,docker_id))

def _parse_events(events_log):
    print("======%s"%(events_log))
    if events_log.split()[1] != 'container' :
        return
    (e_time, e_type, e_event, e_id, e_other)=events_log.split(' ',4)
    if e_event=='attach':
        _start_capture_log("TEST", "fff")
    elif e_event=='destroy':
        _stop_capture_log("TEST", "fff")
    else:
        print("   ignore it...")


if __name__ == '__main__':
    print(cmd)
    p = subprocess.Popen(cmd, shell=False, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    while p.poll() is None:
        line = p.stdout.readline()
        line = line.strip()
        if line:
            _parse_events(line.decode())

