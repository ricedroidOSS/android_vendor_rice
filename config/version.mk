PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0
RISE_CODE := 4.0

RICE_FLAVOR := Tiramisu
RICE_VERSION := 10.1
RICE_CODENAME := Obbattu
RICE_CODE := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
BUILD_DATE_TIME := $(shell date -u '+%Y%m%d%H%M')

ifeq ($(RICE_OFFICIAL), true)
   LIST = $(shell cat vendor/riceOTA/ricedroid.devices)
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      RICE_BUILDTYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
       RICE_BUILDTYPE := COMMUNITY
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

ifeq ($(WITH_GMS), true)
    ifeq ($(TARGET_CORE_GMS), true)
       RICE_PACKAGE_TYPE ?= CORE
    else ifeq ($(TARGET_OPTOUT_GOOGLE_TELEPHONY), true)
       RICE_PACKAGE_TYPE ?= GMS
    else
       RICE_PACKAGE_TYPE ?= PIXEL
    endif
else
       RICE_PACKAGE_TYPE ?= AOSP
endif

# Internal version
LINEAGE_VERSION := riceDroid-$(RICE_CODE)-$(BUILD_DATE_TIME)-$(LINEAGE_BUILD)-v$(RICE_VERSION)-$(RICE_PACKAGE_TYPE)-$(RICE_BUILDTYPE)

# Display version
LINEAGE_DISPLAY_VERSION := riceDroid-$(RICE_CODE)-$(LINEAGE_BUILD)-v$(RICE_VERSION)-$(RICE_PACKAGE_TYPE)-$(RICE_BUILDTYPE)
