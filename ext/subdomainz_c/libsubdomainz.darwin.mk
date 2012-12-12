# -*- makefile -*-

include ${srcdir}/libsubdomainz.gnu.mk

CCACHE := $(shell type -p ccache)
BUILD_DIR := $(shell pwd)

INCFLAGS += -I"$(BUILD_DIR)"

# Work out which arches we need to compile the lib for
ARCHES := 
ARCHFLAGS ?= $(filter -arch %, $(CFLAGS))

ifneq ($(findstring -arch ppc,$(ARCHFLAGS)),)
  ARCHES += ppc
endif

ifneq ($(findstring -arch i386,$(ARCHFLAGS)),)
  ARCHES += i386
endif

ifneq ($(findstring -arch x86_64,$(ARCHFLAGS)),)
  ARCHES += x86_64
endif

ifeq ($(strip $(ARCHES)),)
LIBSUBDOMAINZ_BUILD_DIR = $(BUILD_DIR)/libsubdomainz-$(arch)
# Just build the one (default) architecture
$(LIBSUBDOMAINZ):		
	@mkdir -p "$(LIBSUBDOMAINZ_BUILD_DIR)" "$(@D)"
	@if [ ! -f "$(LIBSUBDOMAINZ_BUILD_DIR)"/Makefile ]; then \
	    echo "Configuring libsubdomainz"; \
	    cd "$(LIBSUBDOMAINZ_BUILD_DIR)" && \
		/usr/bin/env CC="$(CC)" LD="$(LD)" CFLAGS="$(LIBSUBDOMAINZ_CFLAGS)" GREP_OPTIONS="" \
		/bin/sh $(LIBSUBDOMAINZ_CONFIGURE) $(LIBSUBDOMAINZ_HOST) > /dev/null; \
	fi
	cd "$(LIBSUBDOMAINZ_BUILD_DIR)" && $(MAKE)
else
LIBTARGETS = $(foreach arch,$(ARCHES))

# Build a fat binary and assemble
build_subdomainz = \
	mkdir -p "$(BUILD_DIR)"/libsubdomainz-$(1); \
	(if [ ! -f "$(BUILD_DIR)"/libsubdomainz-$(1)/Makefile ]; then \
	    echo "Configuring libsubdomainz for $(1)"; \
	    cd "$(BUILD_DIR)"/libsubdomainz-$(1) && \
	      env CC="$(CCACHE) $(CC)" CFLAGS="-arch $(1) $(LIBSUBDOMAINZ_CFLAGS)" LDFLAGS="-arch $(1)" \
		$(LIBSUBDOMAINZ_CONFIGURE) --host=$(1)-apple-darwin > /dev/null; \
	fi); \
	env MACOSX_DEPLOYMENT_TARGET=10.4 $(MAKE) -C "$(BUILD_DIR)"/libsubdomainz-$(1)

target_subdomainz = $(call build_subdomainz,$(1))

# Work out which arches we need to compile the lib for
ifneq ($(findstring ppc,$(ARCHES)),)
  $(call target_subdomainz,ppc)
endif

ifneq ($(findstring i386,$(ARCHES)),)
  $(call target_subdomainz,i386)
endif

ifneq ($(findstring x86_64,$(ARCHES)),)
  $(call target_subdomainz,x86_64)
endif


$(LIBSUBDOMAINZ):	$(LIBTARGETS)
	# Assemble into a FAT (x86_64, i386, ppc) library
	@mkdir -p "$(@D)"
	@mkdir -p "$(LIBSUBDOMAINZ_BUILD_DIR)"/include
	$(RM) "$(LIBSUBDOMAINZ_BUILD_DIR)"/include/subdomainz.h
	@( \
		printf "#if defined(__i386__)\n"; \
		printf "#include \"libsubdomainz-i386/include/subdomainz.h\"\n"; \
		printf "#elif defined(__x86_64__)\n"; \
		printf "#include \"libsubdomainz-x86_64/include/subdomainz.h\"\n";\
		printf "#elif defined(__ppc__)\n"; \
		printf "#include \"libsubdomainz-ppc/include/subdomainz.h\"\n";\
		printf "#endif\n";\
	) > "$(LIBSUBDOMAINZ_BUILD_DIR)"/include/subdomainz.h
	@( \
		printf "#if defined(__i386__)\n"; \
		printf "#include \"libsubdomainz-i386/include/subdomainztarget.h\"\n"; \
		printf "#elif defined(__x86_64__)\n"; \
		printf "#include \"libsubdomainz-x86_64/include/subdomainztarget.h\"\n";\
		printf "#elif defined(__ppc__)\n"; \
		printf "#include \"libsubdomainz-ppc/include/subdomainztarget.h\"\n";\
		printf "#endif\n";\
	) > "$(LIBSUBDOMAINZ_BUILD_DIR)"/include/subdomainztarget.h

endif
