PKG_NAME := $(shell cat PKG_NAME)
PACKAGE_NAME := $(if $(PKG_NAME),$(PKG_NAME),$(error No package name, please create PKG_NAME))
VERSION := $(shell cat VERSION || true)
VERSION_STRING = $(if $(VERSION),$(VERSION),$(error No version supplied, please add it as 'VERSION=x.y.z'))

OUTPUT_NAME := $(PACKAGE_NAME)_$(VERSION_STRING)
OUTPUT_DIR := pkg/$(OUTPUT_NAME)

PKG_COPY := $(wildcard *.md) $(shell cat PKG_COPY || true)

SED_FILES := $(shell find . -iname '*.json' -type f) $(shell find . -iname '*.lua' -type f)
OUT_FILES := $(SED_FILES:%=$(OUTPUT_DIR)/%)

all: package

package-copy: $(PKG_DIRS) $(PKG_FILES)
	mkdir -p $(OUTPUT_DIR)
ifneq ($(PKG_COPY),)
	cp -r $(PKG_COPY) pkg/$(OUTPUT_NAME)
endif

$(OUTPUT_DIR)/%: %
	mkdir -p $(@D)
	sed -e 's/{{MOD_NAME}}/$(PACKAGE_NAME)/g' $< > $@
	sed -e 's/{{VERSION}}/$(VERSION_STRING)/g' $< > $@

package: package-copy $(OUT_FILES)
	cd pkg && zip -r $(OUTPUT_NAME).zip $(OUTPUT_NAME)

clean:
	rm -rf pkg/$(OUTPUT_NAME)
