
# Push stack
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)

# Subdirs
dir := $(d)/Private
include $(dir)/Rules.mk

# This dir's rules
TGTS_$(d) := $(d)/GNAGrowl.dylib
DEPS_$(d) := $(d)/GNAGrowl.o $(d)/GNARegistration.o $(d)/GNAHelpers.o

$(DEPS_$(d)): CF_TGT := -Isrc

GNA_FMWK_HEADERS_$(d) := $(d)/GNAGrowl.h $(d)/GNARegistration.h $(d)/GNAHelpers.h
GNA_FMWK_LIBS_$(d) := $(TGTS_$(d))

CLEAN_$(d) := $(TGTS_$(d)) $(DEPS_$(d))

$(TGTS_$(d)): LF_TGT := -current_version "1.0.0" -compatibility_version "1.0.0"
$(TGTS_$(d)): $(DEPS_$(d)) $(d)/Private/CFGrowlAdditions.o
	$(DYLIB)

# Update globals
GNA_FMWK_HEADERS := $(GNA_FMWK_HEADERS) $(GNA_FMWK_HEADERS_$(d))
GNA_FMWK_LIBS := $(GNA_FMWK_LIBS) $(GNA_FMWK_LIBS_$(d))

TGT_LIB := $(TGT_LIB) $(TGTS_$(d))
CLEAN := $(CLEAN) $(CLEAN_$(d))

# Pop stack
d := $(dirstack_$(sp))
sp := $(basename $(sp))