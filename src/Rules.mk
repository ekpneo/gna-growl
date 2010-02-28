
# Push stack
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)

# Subdirs
dir := $(d)/GNAGrowl
include $(dir)/Rules.mk

# Pop stack
d := $(dirstack_$(sp))
sp := $(basename $(sp))