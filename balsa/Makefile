### Balsa Makefile
### Created: Thu Feb 10 18:24:25 PST 2011
### By: hutch@VirtuaFedora (Linux)
### With balsa-make-makefile version: 4.0
### Command: balsa-make-makefile -b -p /home/hutch/scratch/Balsa-AES-Core/balsa

### Must use a Bourne shell
SHELL = /bin/sh

### Programs
BALSAC = balsa-c
BALSAMAKETEST = balsa-make-test -b
BALSAMAKEIMPLTEST = balsa-make-impl-test -b
BALSAMAKEBUILTIN = balsa-make-builtin-lib
BALSASIMIMPL = balsa-sim-impl -b
BALSANETLIST = balsa-netlist
BREEZE2PS = breeze2ps
BREEZESIM = breeze-sim
BREEZESIMCTRL = breeze-sim-ctrl
BALSAWAVE = balsa-wave
MAKE = make
RM = rm -f
RM_R = rm -rf

### Options
# -- BALSAIMPORTPATH defined by user
BALSACOPTS_COMPLETE = -b $(BALSAIMPORTPATH) $(BALSACOPTS)
BALSANETLISTOPTS = $(BALSAIMPORTPATH)

### Implementation technology

### Implementation basicenc-ex variables
# -- IMPLPRE_basicenc_ex defined by user
# -- IMPLOPTS_basicenc_ex defined by user
# -- IMPLTECH_basicenc_ex defined by user

### User defined variables
BALSAIMPORTPATH = -I . 
IMPLOPTS_basicenc_ex = --simulation-initialise
IMPLTECH_basicenc_ex = example/dual_b/sim=cver
IMPLPRE_basicenc_ex = -l impl-basicenc-ex.lst -L impl-basicenc-ex.log

### Suffix rules
.SUFFIXES: .balsa .breeze .ps

.breeze.ps:
	$(BREEZE2PS) $(BALSAIMPORTPATH) $*
.balsa.breeze:
	$(BALSAC) $(BALSACOPTS_COMPLETE) $*

all: comp_sbox_mult.breeze comp_sbox_gen.breeze comp_sbox.breeze btypes.breeze basicrkey.breeze basicenc.breeze basic_xtime.breeze basic_mixcol.breeze 
### Balsa rules
basic_mixcol.breeze: btypes.breeze basic_xtime.breeze
basicenc.breeze: btypes.breeze comp_sbox.breeze basic_mixcol.breeze basicrkey.breeze
basicrkey.breeze: btypes.breeze comp_sbox.breeze
comp_sbox.breeze: btypes.breeze comp_sbox_gen.breeze comp_sbox_mult.breeze
comp_sbox_gen.breeze: btypes.breeze
comp_sbox_mult.breeze: btypes.breeze

### Test harness rules
### Implementation rules
impl-basicenc-ex impl-basicenc-ex.log impl-basicenc-ex.lst: basicenc.breeze
	$(BALSANETLIST) --technology '$(IMPLTECH_basicenc_ex)' \
	    $(BALSANETLISTOPTS) $(IMPLPRE_basicenc_ex) $(IMPLOPTS_basicenc_ex) --basename impl-basicenc-ex '[basicenc]'

### Implementation simulations
### Miscellaneous rules
.PHONY: impl-basicenc-ex
.PHONY: depend clean very-clean ps cost help

depend:
	balsa-make-makefile -b -p /home/hutch/scratch/Balsa-AES-Core/balsa

clean:
	$(RM) basic_mixcol.breeze basic_xtime.breeze basicenc.breeze basicrkey.breeze btypes.breeze comp_sbox.breeze comp_sbox_gen.breeze comp_sbox_mult.breeze
	$(RM) basic_mixcol.ps basic_xtime.ps basicenc.ps basicrkey.ps btypes.ps comp_sbox.ps comp_sbox_gen.ps comp_sbox_mult.ps
	$(RM) impl-basicenc-ex.log
	if test -s impl-basicenc-ex.lst; then \
	cat impl-basicenc-ex.lst | while read file; do $(RM) $$file; done; \
	$(RM) impl-basicenc-ex.lst; \
	fi

very-clean: clean
	$(RM_R) .libs

ps: comp_sbox_mult.ps comp_sbox_gen.ps comp_sbox.ps btypes.ps basicrkey.ps basicenc.ps basic_xtime.ps basic_mixcol.ps

cost: comp_sbox_mult.breeze comp_sbox_gen.breeze comp_sbox.breeze btypes.breeze basicrkey.breeze basicenc.breeze basic_xtime.breeze basic_mixcol.breeze
	breeze-cost comp_sbox_mult.breeze
	breeze-cost comp_sbox_gen.breeze
	breeze-cost comp_sbox.breeze
	breeze-cost btypes.breeze
	breeze-cost basicrkey.breeze
	breeze-cost basicenc.breeze
	breeze-cost basic_xtime.breeze
	breeze-cost basic_mixcol.breeze

help:
	@echo 'Target              Meaning'
	@echo '------------------- ---------------------------------------------------'
	@echo 'clean               Remove auto-generated files (except test harnesses)'
	@echo 'cost                Estimate Breeze block costs'
	@echo 'impl-basicenc-ex    Implement block [basicenc] using rules basicenc-ex'
	@echo 'ps                  Generate PostScript graphs for a Breeze files'
	@echo 'suffix rule .breeze Compile Balsa to Breeze'
	@echo 'suffix rule .ps     Generate a PostScript graph of a Breeze file'
	@echo 'very-clean          Remove all auto-generated files'
	@echo

