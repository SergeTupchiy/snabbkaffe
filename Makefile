BUILD_DIR := $(CURDIR)/_build
CONCUERROR := $(BUILD_DIR)/Concuerror/bin/concuerror
CONCUERROR_RUN := $(CONCUERROR) \
	--treat_as_normal shutdown --treat_as_normal normal \
	-x code -x code_server -x error_handler \
	-pa $(BUILD_DIR)/concuerror+test/lib/snabbkaffe/ebin

.PHONY: compile
compile:
	rebar3 do dialyzer, eunit, ct --sname snk_main, xref

concuerror = $(CONCUERROR_RUN) -f $(BUILD_DIR)/concuerror+test/lib/snabbkaffe/test/concuerror_tests.beam -t $(1) || \
	{ cat concuerror_report.txt; exit 1; }

.PHONY: concuerror_test
concuerror_test: $(CONCUERROR)
	rebar3 as concuerror eunit -m concuerror_tests
	$(call concuerror,race_test)
	$(call concuerror,causality_test)
	$(call concuerror,fail_test)
	$(call concuerror,force_order_test)
	$(call concuerror,force_order_multiple_predicates)
	$(call concuerror,force_order_parametrized)

$(CONCUERROR):
	mkdir -p _build/
	cd _build && git clone https://github.com/parapluu/Concuerror.git
	$(MAKE) -C _build/Concuerror/
