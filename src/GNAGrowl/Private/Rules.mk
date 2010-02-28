
# Push stack
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)

# This dir's rules
OBJS_$(d) := $(d)/CFGrowlAdditions.o

$(OBJS_$(d)): CF_TGT :=

CLEAN_$(d) := $(OBJS_$(d))

# Update globals
CLEAN := $(CLEAN) $(CLEAN_$(d))

# Pop stack
d := $(dirstack_$(sp))
sp := $(basename $(sp))