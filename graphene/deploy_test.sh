if [ -z $1 ];then
    echo "${0} [container id]"
    exit 1
fi

docker inspect $1 > /dev/null 2>&1
if [ $? -ne 0 ];then
    echo check container failure
    exit 1
fi


#echo Just a test && exit 0

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/elf/ld-linux-x86-64.so.2  $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/elf/ld.so  $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libc.so $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libc.so.6 $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/dlfcn/libdl.so.2 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/dlfcn/libdl.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libos/liblibos.so.1 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libos/liblibos.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/math/libm.so.6 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/math/libm.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libnss_dns.so.2 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libnss_dns.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl/libpthread.so.0 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl/libpthread.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libresolv.so.2 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libresolv.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/rt/librt.so.1 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/rt/librt.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/src/libsysdb.a $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/src/libsysdb_debug.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/src/libsysdb.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl_db/libthread_db.so.1 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl_db/libthread_db.so $1:/graphene/


docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/login/libutil.so.1 $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/login/libutil.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/debugger/gdb $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux/libpal.so $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/pal-sgx $1:/graphene/

docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Runtime/pal_loader  $1:/graphene/


docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/test/mine/helloworld  $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/test/mine/manifest $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/test/mine/helloworld.manifest.sgx $1:/graphene
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/test/mine/helloworld.sig $1:/graphene/
docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/test/mine/helloworld.token $1:/graphene/


docker cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/libpal.so $1:/graphene/libpal-sgx.so

# mkdir graphene
# export https_proxy=http://child-prc.intel.com:913
# export http_proxy=http://child-prc.intel.com:913
# apt update
# apt install libprotobuf-c1



