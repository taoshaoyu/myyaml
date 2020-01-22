
SGX_TOOL_PATH ?= /opt/graphene/tools/signer
PAL-SGX-SIGN = $(SGX_TOOL_PATH)/pal-sgx-sign
PAL-SGX-GET-TOKEN = $(SGX_TOOL_PATH)/pal-sgx-get-token

#LIB_PAL = /home/taosy/work/opensrc/github.com/oscarlab/graphene/Pal/src/host/Linux-SGX/../../../../Runtime/libpal-Linux-SGX.so
LIB_PAL = /opt/graphene/libpal-sgx.so
KEY_FILE = $(SGX_TOOL_PATH)/enclave-key.pem

all:hello.manifest.sgx hello.token

hello.token: hello.sig
	$(PAL-SGX-GET-TOKEN) -output $@ -sig hello.sig

hello.manifest.sgx: manifest hello
	$(PAL-SGX-SIGN) -libpal $(LIB_PAL) -key $(KEY_FILE) -output $@  -exec hello -manifest manifest

hello:  hello.o
	gcc -o hello hello.o

hello.o:  hello.c
	gcc -c hello.c

clean:
	@rm hello  -fr
	@rm *.o  -fr
	@rm *.token -fr
	@rm *.sig -fr
	@rm *.sgx -fr
