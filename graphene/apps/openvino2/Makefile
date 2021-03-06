# Building the manifest for OpenVINO:
#
# - make                Build for Linux, OpenVINO with Release build
# - make DEBUG=1        Build for Linux, OpenVINO with Debug build, Graphene with debug output
# - make SGX=1          Build for SGX, OpenVINO with Release build
# - make SGX=1 DEBUG=1  Build for SGX, OpenVINO with Debug build, Graphene with debug output
#
# Use `make clean` to remove Graphene-generated files.
#
# Use `make distclean` to further remove the OpenVINO source and installation.

THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
ifeq ($(THIS_DIR), ./)  # workaround Graphene issue #1044 with allowed_files
THIS_DIR :=
endif

MODEL_DIR ?= $(THIS_DIR)model
MODEL_COMMIT ?= acf297c73db8cb3f68791ae1fad4a7cc4a6039e5     # corresponds to tag "2019_R3"
MODEL_NAME ?= squeezenet1.1

OPENVINO_DIR ?= $(THIS_DIR)openvino
OPENVINO_COMMIT ?= ba6e22b1b5ee4cbefcc30e8d9493cddb0bb3dfdf  # corresponds to tag "2019_R2"

# Relative path to Graphene root and key for enclave signing
GRAPHENE_DIR ?= ../../../../..
GRAPHENE_KEY ?= $(GRAPHENE_DIR)/Pal/src/host/Linux-SGX/signer/enclave-key.pem

ifeq ($(DEBUG),1)
GRAPHENE_DEBUG = inline
OPENVINO_BUILD = Debug
LIBTBB_DEBUG   = "sgx.trusted_files.libtbb_debug = file:$(OPENVINO_DIR)/inference-engine/temp/tbb/lib/libtbb_debug.so.2"
else
GRAPHENE_DEBUG = none
OPENVINO_BUILD = Release
LIBTBB_DEBUG   = ""
endif

.PHONY: all
all: $(OPENVINO_DIR)/inference-engine/bin/intel64/$(OPENVINO_BUILD)/benchmark_app $(MODEL_DIR)/$(MODEL_NAME).bin openvino.manifest pal_loader
ifeq ($(SGX),1)
all: openvino.manifest.sgx openvino.sig openvino.token
endif

$(MODEL_DIR)/README.md:
	git clone https://github.com/opencv/open_model_zoo.git $(MODEL_DIR)
	cd $(MODEL_DIR) && git checkout $(MODEL_COMMIT)

$(MODEL_DIR)/classification/squeezenet/1.1/caffe/squeezenet1.1.caffemodel: $(MODEL_DIR)/README.md
	cd $(MODEL_DIR)/tools/downloader && python3 ./downloader.py \
		--name squeezenet1.1 -o $(abspath $(MODEL_DIR))

$(MODEL_DIR)/$(MODEL_NAME).bin: $(MODEL_DIR)/classification/squeezenet/1.1/caffe/squeezenet1.1.caffemodel
	echo asdfasdf
	cd $(OPENVINO_DIR)/model-optimizer && python3 ./mo.py \
		--input_model $(abspath $(MODEL_DIR))/classification/squeezenet/1.1/caffe/squeezenet1.1.caffemodel \
		--output_dir $(abspath $(MODEL_DIR)) --data_type FP16

$(OPENVINO_DIR)/README.md:
	git clone https://github.com/opencv/dldt.git $(OPENVINO_DIR)
	cd $(OPENVINO_DIR) && git checkout $(OPENVINO_COMMIT)
	cd $(OPENVINO_DIR)/inference-engine && git submodule init
	cd $(OPENVINO_DIR)/inference-engine && git submodule update --recursive

$(OPENVINO_DIR)/inference-engine/bin/intel64/$(OPENVINO_BUILD)/benchmark_app: $(OPENVINO_DIR)/README.md
	cd $(OPENVINO_DIR)/inference-engine && mkdir -p build
	cd $(OPENVINO_DIR)/inference-engine/build && cmake -DCMAKE_BUILD_TYPE=$(OPENVINO_BUILD) ..
	$(MAKE) -C $(OPENVINO_DIR)/inference-engine/build

openvino.manifest: openvino.manifest.template
	sed -e 's|$$(GRAPHENE_DIR)|'"$(GRAPHENE_DIR)"'|g' \
		-e 's|$$(GRAPHENE_DEBUG)|'"$(GRAPHENE_DEBUG)"'|g' \
		-e 's|$$(OPENVINO_DIR)|'"$(OPENVINO_DIR)"'|g' \
		-e 's|$$(OPENVINO_DIR_ABSPATH)|'"$(abspath $(OPENVINO_DIR))"'|g' \
		-e 's|$$(MODEL_DIR)|'"$(MODEL_DIR)"'|g' \
		-e 's|$$(OPENVINO_BUILD)|'"$(OPENVINO_BUILD)"'|g' \
		-e 's|$$(LIBTBB_DEBUG)|'$(LIBTBB_DEBUG)'|g' \
		$< > $@

# Generating the SGX-specific manifest (openvino.manifest.sgx), the enclave signature,
# and the token for enclave initialization.
openvino.manifest.sgx: openvino.manifest
	$(GRAPHENE_DIR)/Pal/src/host/Linux-SGX/signer/pal-sgx-sign \
		-libpal $(GRAPHENE_DIR)/Runtime/libpal-Linux-SGX.so \
		-key $(GRAPHENE_KEY) \
		-manifest $< -output $@

openvino.sig: openvino.manifest.sgx

openvino.token: openvino.sig
	$(GRAPHENE_DIR)/Pal/src/host/Linux-SGX/signer/pal-sgx-get-token \
		-sig $< -output $@

# Extra executables
pal_loader:
	ln -s $(GRAPHENE_DIR)/Runtime/pal_loader $@

.PHONY: clean
clean:
	$(RM) *.manifest *.manifest.sgx *.token *.sig pal_loader *.bmp

.PHONY: distclean
distclean: clean
	$(RM) -r $(OPENVINO_DIR) $(MODEL_DIR)
