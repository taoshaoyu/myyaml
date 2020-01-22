mkdir graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/elf/ld-linux-x86-64.so.2  ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/elf/ld.so  ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libc.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libc.so.6 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/dlfcn/libdl.so.2 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/dlfcn/libdl.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libos/liblibos.so.1 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/libos/liblibos.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/math/libm.so.6 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/math/libm.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libnss_dns.so.2 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libnss_dns.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl/libpthread.so.0 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl/libpthread.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libresolv.so.2 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/resolv/libresolv.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/rt/librt.so.1 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/rt/librt.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/src/libsysdb.a ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/src/libsysdb_debug.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/shim/src/libsysdb.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl_db/libthread_db.so.1 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/nptl_db/libthread_db.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/login/libutil.so.1 ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/LibOS/glibc-build/login/libutil.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/debugger/gdb ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux/libpal.so ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/pal-sgx ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Runtime/pal_loader  ./graphene
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/libpal.so ./graphene/libpal-sgx.so

mkdir ./graphene/tools
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/signer ./graphene/tools/ -fr
cp /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/generated_offsets.py ./graphene/tools/ -fr
chmod a+rw /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/signer/enclave-key.pem


tar czvf graphene_install.tar.gz graphene/


