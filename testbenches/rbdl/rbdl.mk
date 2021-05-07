RM=rm -f
#RBD_RISCV_PATH=/root/rbd-benchmarks/
#RBD_BENCHMARKS_PATH=$(RBD_BENCHMARKS)
#RBDL_PATH=$(RBD_BENCHMARKS_PATH)/libs/rbdl/install
#EIGEN3_PATH=$(RBDL_PATH)/include/eigen3
#RESULTS_PATH=$(RESULTS)

RBD_BENCHMARKS_PATH=$(RBD_BENCHMARKS)
RBDL_PATH=$(RBD_BENCHMARKS_PATH)/libs/rbdl/install
EIGEN3_PATH=$(RBDL_PATH)/include/eigen3
RESULTS_PATH=$(RESULTS)
GEMMINI_INCLUDE_PATH=$(RBD_BENCHMARKS_PATH)/libs/rbdl/gemmini-rocc-tests/

CXX=riscv64-unknown-linux-gnu-g++
#CXX=riscv64-unknown-elf-g++
CXXFLAGS += -D_USE_MATH_DEFINES -DRBD_BENCHMARKS_DIR=\"$(RBD_BENCHMARKS_PATH)\" -DRESULTS_DIR=\"$(RESULTS_PATH)\"
#CXXFLAGS += -DRBD_BENCHMARKS_DIR=\"$(RBD_BENCHMARKS_PATH)\" -DRESULTS_DIR=\"$(RESULTS_PATH)\"
#CXXFLAGS += -I$(RBDL_PATH) -I$(RBDL_PATH)/include -I$(EIGEN3_PATH)
CXXFLAGS += -I$(RBDL_PATH) -I$(RBDL_PATH)/include  -I$(GEMMINI_INCLUDE_PATH)
#CXXFLAGS += -O3 -DNDEBUG -std=c++11
CXXFLAGS += -O0 -g -DDEBUG -std=c++11
CXXFLAGS += -fno-omit-frame-pointer

##x86:
#LDFLAGS += -L$(RBDL_PATH)/lib -lrbdl -lrbdl_urdfreader -lrt
#LDFLAGS += -Wl,-rpath,$(RBDL_PATH)/lib

##RISC-V:
# LDFLAGS += -L$(RBDL_PATH)/lib64 -lrbdl -lrbdl_urdfreader -lrt -lmath
# LDFLAGS += -Wl,-rpath,$(RBDL_PATH)/lib64

#RISC-V Static:
 LDFLAGS += -static -L$(RBDL_PATH)/lib64 -L$(RBDL_PATH)/bin -lrbdl -lrbdl_urdfreader 
 LDFLAGS += -Wl,-rpath,$(RBDL_PATH)/lib64


$(TARGET): $(TARGET).o
	echo $(RBD_BENCHMARKS_PATH)
	$(CXX) $(TARGET).o -o $(TARGET) $(LDFLAGS)

$(TARGET).o: $(TARGET).cc
	$(CXX) $(CXXFLAGS) -o $(TARGET).o -c $(TARGET).cc

clean:
	$(RM) *.o $(TARGET)
