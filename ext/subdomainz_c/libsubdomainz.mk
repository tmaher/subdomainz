# -*- makefile -*-

include ${srcdir}/libsubdomainz.gnu.mk

$(LIBSUBDOMAINZ):		
	@mkdir -p "$(LIBSUBDOMAINZ_BUILD_DIR)" "$@(D)"
	@if [ ! -f "$(LIBSUBDOMAINZ_BUILD_DIR)"/Makefile ]; then \
	    echo "Configuring libsubdomainz"; \
	    cd "$(LIBSUBDOMAINZ_BUILD_DIR)" && \
		/usr/bin/env CFLAGS="$(LIBSUBDOMAINZ_CFLAGS)" GREP_OPTIONS="" \
		/bin/sh $(LIBSUBDOMAINZ_CONFIGURE) $(LIBSUBDOMAINZ_HOST) > /dev/null; \
	fi
	$(MAKE) -C "$(LIBSUBDOMAINZ_BUILD_DIR)"
