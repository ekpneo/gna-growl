
.SUFFIXES:
.SUFFIXES: .m .c .o

all: targets

# Subdirectories
dir := src
include $(dir)/Rules.mk

# Generic rules
%.o: %.c
	$(C_COMP)

%.o: %.m
	$(M_COMP)

# This dir's rules
GNA_FMWK := GNAGrowl.framework

$(GNA_FMWK): $(GNA_FMWK_HEADERS) $(GNA_FMWK_LIBS) Info.plist
	@echo "Making Framework"
	mkdir -p $@/Versions/A
	mkdir -p $@/Versions/A/Resources
	mkdir -p $@/Versions/A/Headers
	cp $(GNA_FMWK_LIBS) $@/Versions/A/$(notdir $(basename $(GNA_FMWK_LIBS)))
	cp $(GNA_FMWK_HEADERS) $@/Versions/A/Headers
	cp Info.plist $@/Versions/A/Resources
	(cd $@/Versions; ln -s A Current)
	(cd $@; ln -s Versions/Current/GNAGrowl .)
	(cd $@; ln -s Versions/Current/Resources .)
	(cd $@; ln -s Versions/Current/Headers .)


CLEAN := $(CLEAN) $(GNA_FMWK)

TGT_FMWK := $(TGT_FMWK) $(GNA_FMWK)

GROWL := gna_growl
GROWL_OBJS := $(GROWL:%=%.o)
GROWL_DEPS := $(GNA_FMWK)

$(GROWL_OBJS): CF_TGT := -F.
$(GROWL_OBJS): $(GROWL_DEPS)

$(GROWL): LF_TGT := -F. -framework GNAGrowl
$(GROWL): $(GROWL_OBJS)
	$(LINK)

post_$(GROWL): $(GROWL)
	@echo "Changing install name"

TGT_BIN := $(TGT_BIN) $(GROWL) post_$(GROWL)

CLEAN := $(CLEAN) $(GROWL) $(GROWL_OBJS)

# Specific rules
.PHONY: targets
targets: $(TGT_LIB) $(TGT_FMWK) $(TGT_BIN)

.PHONY: clean
clean:
	rm -rf $(CLEAN)

.SECONDARY: $(CLEAN)