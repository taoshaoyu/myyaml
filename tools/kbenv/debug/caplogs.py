import shlex
import subprocess

#shell_cmd = 'python3 ./subprogram2.py'
#shell_cmd = 'docker events --format "Type={{.Type}}: From={{.From}} Action={{.Action}} ID={{.ID}} Status={{.Status}}"'
shell_cmd = 'docker events'

known_container_names = ('etcd', 'kube-apiserver', 'kube-controller-manager', 'kube-scheduler', 'kubelet', 'kube-proxy', 'busybox')
loged_image_names=('rke-tools')
loged_container_names=('kube-api-auth', 'kube-flannel','install-cni', 'coredns')
save_fn_list=[]

def _prepare_fold():
    print()

def _start_capture_log(filename):
    print("    Start to save to %s..."%(filename))

def _stop_capture_log(filename):
    print("    Stop to save to %s..."%(filename))

def _need_to_save(container_name):
    for i in loged_container_names:
        if container_name.find(i) != -1 :
            return i
    return None

def _add_path_to_save(fullpath):
    if fullpath not in  save_fn_list:
        save_fn_list.append(fullpath)
        return fullpath
    index=0
    for i in save_fn_list:
        if i.find(fullpath) != -1 :
            if len(i.split('__'))==2:
                if int(i.split('__')[1])>index :
                    index=int(i.split('__')[1])
    index = index+1
    fullpath = fullpath+"__"+str(index)
    save_fn_list.append(fullpath)
    return fullpath

def _create_filename_to_save(path_name, image_name, container_name):
    if container_name in known_container_names:
        return _add_path_to_save( path_name+'/'+container_name )
    try:
        base_image_name=image_name.split(':')[0].split('/')[1]
    except:
        if image_name.split(':')[0] == 'sha256' :
            simple_container_name=_need_to_save(container_name)
            if simple_container_name != None:
                return _add_path_to_save( path_name + '/' + simple_container_name )
        return None
    if base_image_name in loged_image_names:
        return _add_path_to_save( path_name + '/' + container_name )
    return None

def _parse_events(events_log):
#    print("======%s"%(events_log))
    if events_log.split()[1] != 'container' :
        return
    (e_time, e_type, e_event, e_id, e_other)=events_log.split(' ',4)

    e_other=e_other[1:-1]
    l_e_other=e_other.split(',')
    l_container_info=[] 
    for i in l_e_other:
        l_container_info.append(i.strip())
    
    for i in l_container_info:
        try:
            (k,v)=i.split('=')
            if k=='image':
                image_name=v
            elif k=='name':
                container_name=v
        except:
            pass
    print("==image:%s, container:%s, action:%s"%(image_name, container_name,e_event))

#    if e_event=='attach' or e_event=='start':  // maybe attach -> start, so ignore attach
    if e_event=='start':
        filename=_create_filename_to_save("/tmp",image_name, container_name)
        if filename != None:
            _start_capture_log(filename)
    elif e_event=='destroy':
        filename=_create_filename_to_save("/tmp",image_name, container_name)
        if filename != None:
            _stop_capture_log(filename)
    return 


if __name__ == '__main__':
#    print(cmd)
    p = subprocess.Popen(shlex.split(shell_cmd), shell=False, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    while p.poll() is None:
        line = p.stdout.readline()
        line = line.strip()
        if line:
            _parse_events(line.decode())

