BUILD_DIR ?= build
INSTALL_DIR ?= install

RBDL_ZIP_URL := https://github.com/rbdl/rbdl/archive/refs/tags/v2.6.0.zip
RBDL_ZIP_LOCAL := v2.6.0.zip
RBDL_SRC_DIR := rbdl-src


.DEFAULT_GOAL := all

.PHONY: all clean
all: $(INSTALL_DIR)

$(RBDL_ZIP_LOCAL):
	wget -q $(RBDL_ZIP_URL) -O $(RBDL_ZIP_LOCAL)

$(RBDL_SRC_DIR): $(RBDL_ZIP_LOCAL)
	unzip -q -o $(RBDL_ZIP_LOCAL)
	mv rbdl-2.6.0 $(RBDL_SRC_DIR)
	touch $(RBDL_SRC_DIR)

$(INSTALL_DIR): $(RBDL_SRC_DIR) $(EIGEN_INCLUDE_DIR)
	# Unset ROS_ROOT to avoid building ROS-related URDF reader stuff, which is not needed and appears to be broken anyway.
	echo $(abspath $(INSTALL_DIR))
	{ \
	unset -v ROS_ROOT; \
	mkdir -p $(BUILD_DIR); \
	cd $(BUILD_DIR); \
	cmake -DRBDL_USE_SIMPLE_MATH=TRUE -DCMAKE_INSTALL_PREFIX=$(abspath $(INSTALL_DIR)) -DRBDL_BUILD_ADDON_URDFREADER=ON $(abspath $(RBDL_SRC_DIR)); \
	$(MAKE) install; \
	}

clean: clean-eigen
	-rm -f $(RBDL_ZIP_LOCAL)
	-rm -rf $(BUILD_DIR)
	-rm -rf $(RBDL_SRC_DIR)
	-rm -rf $(INSTALL_DIR)
