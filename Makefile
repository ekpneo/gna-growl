CF_ALL = -g -Wall
MF_ALL =
LF_ALL = -framework Foundation -framework AppKit
LL_ALL =

CC = gcc
C_COMP = $(CC) $(CF_ALL) $(CF_TGT) -o $@ -c $<
M_COMP = $(CC) $(CF_ALL) $(MF_ALL) $(CF_TGT) $(MF_TGT) -o $@ -c $<
LINK  = $(CC) $(LF_ALL) $(LF_TGT) -o $@ $^ $(LL_TGT) $(LL_ALL)
DYLIB = $(CC) -dynamiclib $(LF_ALL) $(LF_TGT) -o $@ $^ $(LL_TGT) $(LL_ALL)

include Rules.mk
