# Additional props
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.google.ime.theme_id=5 \
    drm.service.enabled=true \
    media.mediadrmservice.enable=true \
    persist.sys.disable_rescue=true \
    ro.opa.eligible_device=true

# Setupwizard
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.day_night_mode_enabled=true \
    setupwizard.feature.lifecycle_refactoring=true \
    setupwizard.feature.notification_refactoring=true \
    setupwizard.feature.portal_notification=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.show_support_link_in_deferred_setup=false \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.theme=glif_v3_light

# Default notification/alarm sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=oneplus.ogg \
    ro.config.alarm_alert=into_the_night.ogg

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Rice properties - used by firmware version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.rice.maintainer=$(RICE_MAINTAINER) \
    ro.rice.code=$(RICE_CODENAME) \
    ro.riseui.code=$(RISE_CODE) \
    ro.rice.packagetype=$(RICE_PACKAGE_TYPE) \
    ro.rice.releasetype=$(RICE_BUILDTYPE) \
    ro.rice.version?=$(RICE_VERSION) \
    ro.rice.chipset?=$(RICE_CHIPSET) \
    ro.rice.build.version=$(LINEAGE_VERSION) \
    ro.rice.display.version?=$(LINEAGE_DISPLAY_VERSION) \
    ro.rice.platform_release_codename=$(RICE_FLAVOR) \
    ro.ricelegal.url=https://www.manginasal.com/

TARGET_ENABLE_PRIVAPP_ENFORCEMENT ?= true
ifeq ($(TARGET_ENABLE_PRIVAPP_ENFORCEMENT), true)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce
else 
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=log
endif

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := art/build/boot/boot-image-profile.txt

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
$(call inherit-product-if-exists, external/faceunlock/config.mk)
endif

# Blurs
ifeq ($(TARGET_ENABLE_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1 \
    ro.launcher.blur.appLaunch=0
endif

# Default boosting durations 
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.powerhal.interaction.max=64 \
    persist.sys.powerhal.interaction.max_default=64 \
    persist.sys.powerhal.interaction.max_boost=500

# Disable async MTE on system_server
PRODUCT_PRODUCT_PROPERTIES += \
    arm64.memtag.process.system_server=off

ifeq ($(strip $(TARGET_BUILD_APERTURE_CAMERA)),true)
PRODUCT_PACKAGES += \
    Aperture
    
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/lineage/overlay/aperture
endif

ifeq ($(strip $(TARGET_BUILD_GRAPHENEOS_CAMERA)),true)
PRODUCT_PACKAGES += \
    GrapheneCamera
    
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/lineage/overlay/graphene
endif

# Bootanimation
ifeq ($(SUSHI_BOOTANIMATION),720)
# Sushi Bootanimation 720 by saavedra3
PRODUCT_COPY_FILES += vendor/lineage/bootanimation/sushi_bootanimation_720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(SUSHI_BOOTANIMATION),1080)
# Sushi Bootanimation 1080 by saavedra3
PRODUCT_COPY_FILES += vendor/lineage/bootanimation/sushi_bootanimation_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(SUSHI_BOOTANIMATION),1440)
# Sushi Bootanimation 1440 by saavedra3
PRODUCT_COPY_FILES += vendor/lineage/bootanimation/sushi_bootanimation_1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
PRODUCT_COPY_FILES += vendor/lineage/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

# DesktopMode
PRODUCT_PACKAGES += \
    DesktopMode

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

$(call inherit-product, packages/services/VncFlinger/product.mk)

# Extra packages
PRODUCT_PACKAGES += \
    Backgrounds \
    GameSpace \
    RepainterServicePriv \
    ParallelSpace \
    OmniJaws \
    Updater
    
TARGET_ENABLE_PIXEL_GBOARD_PADDINGS ?= true
ifeq ($(TARGET_ENABLE_PIXEL_GBOARD_PADDINGS), true)
# Gboard
# Keyboard bottom padding in dp for portrait mode and height ratio
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_b=8 \
    ro.com.google.ime.height_ratio=1.075


endif

ifeq ($(TARGET_USE_PIXEL_FINGERPRINT), true)
BUILD_FINGERPRINT := "google/cheetah/cheetah:13/TQ1A.230205.002/9471150:user/release-keys"

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cheetah-user 13 TQ1A.230205.002 9471150 release-keys"

endif
