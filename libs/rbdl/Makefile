BUILD_DIR ?= build
INSTALL_DIR ?= install

RBDL_ZIP_URL := https://github.com/rbdl/rbdl/archive/refs/tags/v2.6.0.zip
RBDL_ZIP_LOCAL := v2.6.0.zip
RBDL_SRC_DIR := rbdl
CMAKE_TARGZ_URL := https://github.com/Kitware/CMake/releases/download/v3.20.1/cmake-3.20.1-linux-x86_64.tar.gz
CMAKE_TARGZ_LOCAL := cmake-3.20.1-linux-x86_64.tar.gz
CMAKE_INSTALL_DIR := cmake-3.20.1-linux-x86_64


.DEFAULT_GOAL := all

.PHONY: all clean
all: $(INSTALL_DIR)



$(CMAKE_INSTALL_DIR):
	wget $(CMAKE_TARGZ_URL)
	tar -xvf $(CMAKE_TARGZ_LOCAL)
	

$(INSTALL_DIR): $(RBDL_SRC_DIR) $(EIGEN_INCLUDE_DIR) $(CMAKE_INSTALL_DIR)
	# Unset ROS_ROOT to avoid building ROS-related URDF reader stuff, which is not needed and appears to be broken anyway.
	echo $(abspath $(INSTALL_DIR))
	{ \
	unset -v ROS_ROOT; \
	mkdir -p $(BUILD_DIR); \
	cd $(BUILD_DIR); \
	../$(CMAKE_INSTALL_DIR)/bin/cmake -DCMAKE_VERBOSE_MAKEFILE=1 -DCMAKE_C_COMPILER=riscv64-unknown-linux-gnu-gcc -DCMAKE_C_COMPILER_WORKS=1 -DCMAKE_CXX_COMPILER_WORKS=1 -DRISCV_CPU=rv64 -DCMAKE_BUILD_TYPE=Debug -DRBDL_USE_SIMPLE_MATH=TRUE -DCMAKE_INSTALL_PREFIX=$(abspath $(INSTALL_DIR)) -DRBDL_BUILD_ADDON_URDFREADER=ON $(abspath $(RBDL_SRC_DIR)); \
	$(MAKE) install; \
	}
#-DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS="-fno-omit-frame-pointer" 

clean: clean
	-rm -f $(CMAKE_TARGZ_LOCAL)
	-rm -rf $(CMAKE_INSTALL_DIR)
	-rm -f $(RBDL_ZIP_LOCAL)
	-rm -rf $(BUILD_DIR)
	-rm -rf $(INSTALL_DIR)
