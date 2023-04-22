#
# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2022-2023 The OrangeFox Recovery Project
# SPDX-License-Identifier: GPL-3.0-or-later
#

LOCAL_PATH := device/xiaomi/lisa

# fscrypt policy
TW_USE_FSCRYPT_POLICY := 2

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# vendor_boot as recovery
#ifeq ($(OF_VENDOR_BOOT_RECOVERY),1)

$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    shell_and_utilities_vendor_ramdisk \
    resize2fs.vendor_ramdisk \
    fsck.vendor_ramdisk \
    tune2fs.vendor_ramdisk

PRODUCT_PACKAGES += adbd.vendor_ramdisk

#endif
# end: vendor_boot

# API
PRODUCT_TARGET_VNDK_VERSION := 31
PRODUCT_SHIPPING_API_LEVEL := 30

# A/B
ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

PRODUCT_PACKAGES += \
    otapreopt_script \
    checkpoint_gc \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.1-service \
    bootctrl.lahaina \
    bootctrl.lahaina.recovery
	
PRODUCT_PACKAGES_DEBUG += \
    bootctl	

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd 

# Qcom decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    vendor/qcom/opensource/commonsys-intf/display

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true

# platform
PLATFORM_VERSION := 99.87.36

# Platform security
PLATFORM_SECURITY_PATCH := 2127-12-31

# Last stable
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# Vendor security
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Modules
TARGET_RECOVERY_DEVICE_MODULES += libion vendor.display.config@1.0 vendor.display.config@2.0 libdisplayconfig.qti

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

#Display
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui

# Copy modules for depmod
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/exfat.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/exfat.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/adsp_loader_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/adsp_loader_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/hwid.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/hwid.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/goodix_core.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/goodix_core.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/msm_drm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/msm_drm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/qti_battery_charger_main.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/qti_battery_charger_main.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/snd_event_dlkm.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/snd_event_dlkm.ko \
    $(LOCAL_PATH)/recovery/root/vendor/lib/modules/xiaomi_touch.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/xiaomi_touch.ko \
#
