
# =======================================================
# Makefile C
#     Fabien B. <fabien.bavent@gmail.com>
#
# This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# =======================================================

# -------------------------------------------------------
# Config
PACKAGE = name
BUILD = v0.0

# -------------------------------------------------------
# Programs
CC = gcc
CXX = g++
LD = ld
AR = ar rc

# -------------------------------------------------------
# Flags building
CFLAGS  = -Wall -Wextra
CFLAGS += -Iinclude/
LFLAGS  =

CFLAGS_debug = $(CFLAGS) -ggdb3
CFLAGS_release = $(CFLAGS) -O3
CFLAGS_testing = $(CFLAGS) -ggdb3 --coverage

LFLAGS_debug = $(LFLAGS)
LFLAGS_release = $(LFLAGS)
LFLAGS_testing = $(LFLAGS) --coverage


# -------------------------------------------------------
# Extract deliveries
FRAGMENTS = $(patsubst src/%,%,$(wildcard src/*))
BIN =
LIB =
SBIN =
SLIB =
TEST = pmanager_UT



SRCS =  $(wildcard src/pmanager/*.cpp) $(wildcard src/pmedium/*.cpp) $(wildcard src/tests/*.cpp)
OBJS = $(patsubst src/%.cpp,obj/testing/%.o,$(SRCS))
DEPS = $(patsubst src/%.cpp,obj/testing/%.d,$(SRCS))


# -------------------------------------------------------
# Create report
REPORT_CPPCHECK = $(patsubst %,report_cppcheck_%.xml,$(FRAGMENTS))
REPORT_RATS = $(patsubst %,report_rats_%.xml,$(FRAGMENTS))
REPORT_CHECK = $(patsubst %,report_check_%.xml,$(TEST))
REPORT_GCOV = $(patsubst %,report_gcov_%.xml,$(TEST))
REPORT_VALGRIND = $(patsubst %,report_valgrind_%.xml,$(TEST))

REPORTS  = ${REPORT_GCOV} ${REPORT_VALGRIND} ${REPORT_CPPCHECK}
REPORTS += ${REPORT_RATS} ${REPORT_CHECK}

COV_HTML = $(patsubst %,cov_%,$(TEST))
BIN_UT = $(patsubst %,test/%,$(TEST))


# -------------------------------------------------------
# Verbose level
V1 = @
V2 = @
V3 = @

E1 = @ echo
E2 = @ true
E3 = @ true



all: test/pmanager_UT

# =======================================================
#      Compile sources files
# =======================================================

# -------------------------------------------------------
# Compile CPP sources
obj/debug/%.o: src/%.cpp obj/debug/%.d
	$(E1) "Compile CPP source $@"
	@ mkdir -p $(dir $@)
	$(V1) $(CXX) -c -o $@ $(CFLAGS_debug) $<

obj/debug/%.d: src/%.cpp
	$(E2) "Create CPP dependencies $@"
	@ mkdir -p $(dir $@)
	$(V2) $(CXX) -MM -o $@ $(CFLAGS_debug) $<

obj/release/%.o: src/%.cpp obj/release/%.d
	$(E1) "Compile CPP source $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -c -o $@ $(CFLAGS_release) $<

obj/release/%.d: src/%.cpp
	@ echo "Create CPP dependencies $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -MM -o $@ $(CFLAGS_release) $<

obj/testing/%.o: src/%.cpp obj/testing/%.d
	@ echo "Compile CPP source $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -c -o $@ $(CFLAGS_testing) $<

obj/testing/%.d: src/%.cpp
	@ echo "Create CPP dependencies $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -MM -o $@ $(CFLAGS_testing) $<

# -------------------------------------------------------
# Compile C sources
obj/debug/%.o: src/%.c obj/debug/%.d
	@ echo "Compile C source $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -c -o $@ $(CFLAGS_debug) $<

obj/debug/%.d: src/%.c
	@ echo "Create C dependencies $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -MM -o $@ $(CFLAGS_debug) $<

obj/release/%.o: src/%.c obj/release/%.d
	@ echo "Compile C source $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -c -o $@ $(CFLAGS_release) $<

obj/release/%.d: src/%.c
	@ echo "Create Compile dependencies $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -MM -o $@ $(CFLAGS_release) $<

obj/testing/%.o: src/%.c obj/testing/%.d
	@ echo "Compile C source $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -c -o $@ $(CFLAGS_testing) $<

obj/testing/%.d: src/%.c
	@ echo "Create C dependencies $@"
	@ mkdir -p $(dir $@)
	@ $(CXX) -MM -o $@ $(CFLAGS_testing) $<


# =======================================================
#      Link objects files
# =======================================================


slib/%.so: $(OBJS_%)
	@ echo "Linking static library $@"
	@ mkdir -p $(dir $@)
	@ $(AR) $@ $^

lib/%.so: $(OBJS_%)
	@ echo "Linking shared library $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -shared -o $@ $(LFLAGS_debug) $^

build/lib/%.so: $(OBJS_%)
	@ echo "Linking shared library $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -shared -o $@ $(LFLAGS_release) $^

bin/%: $(OBJS_%)
	@ echo "Linking program $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -o $@ $(LFLAGS_debug) $^

build/bin/%: $(OBJS_%)
	@ echo "Linking program $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -o $@ $(LFLAGS_release) $^

sbin/%: $(OBJS_%)
	@ echo "Linking program $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -o $@ $(LFLAGS_debug) $^

build/sbin/%: $(OBJS_%)
	@ echo "Linking program $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -o $@ $(LFLAGS_release) $^

test/%: $(OBJS_%)
	@ echo "Linking program $@"
	@ mkdir -p $(dir $@)
	@ $(LD) -o $@ $(LFLAGS_testing) $^ `pkg-config --libs check`


# =======================================================
#      Specials targets
# =======================================================

TARS  = $(PACKAGE)-build-$(BUILD).tar.gz 
TARS += $(PACKAGE)-devel-$(BUILD).tar.gz 
TARS += $(PACKAGE)-reports-$(BUILD).tar.gz 

destroy: clean
	@ rm -rf bin lib sbin slib build *.lcov cov_* *.xml test *.tar.gz

clean:
	@ rm -rf obj

coverage: ${COV_HTML}

check: ${REPORT_CHECK}

sonar: ${REPORTS}
	@ sonnar-runner.sh

everything: coverage sonar package

package: $(TARS)

$(PACKAGE)-build-$(BUILD).tar.gz: $(BUILD)
	@ tar czf $@ -C build .

$(PACKAGE)-devel-$(BUILD).tar.gz: $(DEVEL)
	@ tar czf $@ bin lib sbin slib test include

$(PACKAGE)-reports-$(BUILD).tar.gz: $(REPORTS)
	@ tar czf $@ report*

none_:
-include $(DEPS)


# =======================================================
#      Code coverage HTML
# =======================================================

SED_LCOV  = -e '/SF:\/usr.*/,/end_of_record/d'
SED_LCOV += -e '/SF:.*\/src\/tests\/.*/,/end_of_record/d'

# -------------------------------------------------------
# Create coverage HTML report
%.lcov: ./test/%
	@ find -name *.gcda | xargs -r rm
	@ mkdir -p mfast
	@ touch mfast/d
	@ rm mfast/*
	@ CK_FORK=no $<
	@ lcov -c --directory . -b . -o $@
	@ sed $(SED_LCOV) -i $@

cov_%: %.lcov
	@ genhtml -o $@ $<


# =======================================================
#      Code quality reports
# =======================================================

# -------------------------------------------------------
# Static report - depend of sources
report_cppcheck_%.xml: src/%
	@ cppcheck -v --enable=all --xml-version=2 -Iinclude $(wildcard $</*) 2> $@

report_rats_%.xml: src/%
	@ rats -w 3 --xml $(wildcard $</*) > $@


# -------------------------------------------------------
# Dynamic report - depend of tests
report_check_%.xml: test/%
	@ mkdir -p mfast
	@ touch mfast/d
	@ rm mfast/*
	@ $< -xml

report_gcov_%.xml: test/%
	@ find -name *.gcda | xargs -r  rm
	@ mkdir -p mfast
	@ touch mfast/d
	@ rm mfast/*
	@ CK_FORK=no $<
	@ gcovr -x -r . > $@

report_valgrind_%.xml: test/%
	@ mkdir -p mfast
	@ touch mfast/d
	@ rm mfast/*
	@ CK_FORK=no valgrind --xml=yes --xml-file=$@  $<


# -------------------------------------------------------
# -------------------------------------------------------
