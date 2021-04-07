RM=rm -f
RBD_BENCHMARKS_PATH=$(RBD_BENCHMARKS)
RBDL_PATH=$(RBD_BENCHMARKS_PATH)/libs/rbdl/install
EIGEN3_PATH=$(RBDL_PATH)/include/eigen3
RESULTS_PATH=$(RESULTS)

CXXFLAGS += -DRBD_BENCHMARKS_DIR=\"$(RBD_BENCHMARKS_PATH)\" -DRESULTS_DIR=\"$(RESULTS_PATH)\"
#CXXFLAGS += -I$(RBDL_PATH) -I$(RBDL_PATH)/include -I$(EIGEN3_PATH)
CXXFLAGS += -I$(RBDL_PATH) -I$(RBDL_PATH)/include 
#CXXFLAGS += -O3 -DNDEBUG -std=c++11
CXXFLAGS += -O0 -g -DDEBUG -std=c++11
CXXFLAGS += -fno-omit-frame-pointer

#x86:
LDFLAGS += -L$(RBDL_PATH)/lib -lrbdl -lrbdl_urdfreader -lrt
LDFLAGS += -Wl,-rpath,$(RBDL_PATH)/lib

#RISC-V:
# LDFLAGS += -L$(RBDL_PATH)/lib64 -lrbdl -lrbdl_urdfreader -lrt
# LDFLAGS += -Wl,-rpath,$(RBDL_PATH)/lib64


$(TARGET): $(TARGET).o
	echo $(RBD_BENCHMARKS_PATH)
	$(CXX) $(TARGET).o -o $(TARGET) $(LDFLAGS)

$(TARGET).o: $(TARGET).cc
	$(CXX) $(CXXFLAGS) -o $(TARGET).o -c $(TARGET).cc

clean:
	$(RM) *.o $(TARGET)
