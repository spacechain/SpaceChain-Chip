VHDLS := VHDS
include build.mk

VHDS += tests/gpsif_tb.vhd
VHDS += tests/gpsif_tb_pkg.vhd
VHDS += tools/tests/tap/test_pkg.vhd

VHDL_TESTS := gpsif_tb

# if gpsif repo is inside the soc_top repo, pull in other vhdl files
# and build gpsif_tb
MK_UTILS := $(wildcard ../../tools/mk_utils.mk)
ifeq ($(MK_UTILS),)
	MK_UTILS := $(wildcard ../tools/mk_utils.mk)
	include $(MK_UTILS)
	VHDS += $(call include_vhdl,../lib/reg_file_struct)
endif
MK_UTILS := $(wildcard ../../tools/mk_utils.mk)
ifneq ($(MK_UTILS),)
	include $(MK_UTILS)
	VHDS += $(call include_vhdl,../cpu)
	VHDS += $(call include_vhdl,../ring_bus)
	VHDS += $(call include_vhdl,../../lib/fixed_dsm_pkg)
	VHDS += $(call include_vhdl,../../lib/reg_file_struct)
	VHDS += $(call include_vhdl,../../lib/memory_tech_lib)
	VHDS += $(call include_vhdl,../../lib/hwutils)
endif

VHDL_TOPS += $(VHDL_TESTS)

TOOLS_DIR := $(firstword $(wildcard ../../tools) tools)

all: $(VHDL_TOPS)

work-obj93.cf: $(VHDS)

tests/gpsif_tb.ghw: gpsif_tb
	./gpsif_tb --wave=$@ --stop-time=9400us --ieee-asserts=disable

RUNTESTS := $(TOOLS_DIR)/tests/runtests
$(RUNTESTS):
	make -C $(dir $@)

check: $(RUNTESTS) $(VHDL_TESTS)
	$(RUNTESTS) test_bins

tap: $(RUNTESTS) $(VHDL_TESTS)
	$(RUNTESTS) -t test_bins

include $(TOOLS_DIR)/ghdl.mk

clean:
	rm -f *.cf *.o $(VHDL_TOPS) *_tap tests/*.ghw
	rm -f gpsif.vhd gpsif_reg.vhd cacode.vhd gpsif_db.vhd gpsif_buf.vhd rbus_adp.vhd
	make -C $(dir $(RUNTESTS)) clean

.PHONY: all clean check tap
