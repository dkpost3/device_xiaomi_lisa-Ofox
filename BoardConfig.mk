#
# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2022-2023 The OrangeFox Recovery Project
# SPDX-License-Identifier: GPL-3.0-or-later
#


DEVICE_PATH := device/xiaomi/lisa

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_DUP_RULES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := $(TARGET_CPU_VARIANT)
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lisa
TARGET_NO_BOOTLOADER := true

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := lahaina
TARGET_BOARD_PLATFORM_GPU := qcom-adreno642l
BOARD_VENDOR := xiaomi

# Kernel
BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_PAGESIZE := 4096

BOARD_KERNEL_BASE          := 0x00000000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_DTB_OFFSET           := 0x01f00000
BOARD_KERNEL_OFFSET        := 0x00008000

BOARD_KERNEL_IMAGE_NAME := kernel
BOARD_KERNEL_SEPARATED_DTBO := true


VENDOR_CMDLINE := " console=null \
                    androidboot.hardware=qcom \
                    androidboot.memcg=1 \
                    lpm_levels.sleep_disabled=1 \
                    video=vfb:640x400,bpp=32,memsize=3072000 \
                    msm_rtb.filter=0x237 \
                    service_locator.enable=1 \
                    androidboot.usbcontroller=a600000.dwc3 \
                    swiotlb=0 \
                    loop.max_part=7 \
                    cgroup.memory=nokmem,nosocket \
                    firmware_class.path=/vendor/firmware_mnt/image \
                    pcie_ports=compat \
                    loop.max_part=7 \
                    iptable_raw.raw_before_defrag=1 \
                    ip6table_raw.raw_before_defrag=1 "

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)

# Kernel
# whether to do an inline build of the kernel sources
ifeq ($(FOX_BUILD_FULL_KERNEL_SOURCES),1)
     TARGET_KERNEL_SOURCE := kernel/xiaomi/lisa
     TARGET_KERNEL_CONFIG := lisa_defconfig
     TARGET_KERNEL_CLANG_COMPILE := true
     KERNEL_SUPPORTS_LLVM_TOOLS := true
     TARGET_KERNEL_CROSS_COMPILE_PREFIX := llvm-
     KERNEL_LD := LD=ld.lld
#    TARGET_KERNEL_ADDITIONAL_FLAGS := AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip
     TARGET_KERNEL_ADDITIONAL_FLAGS += HOSTCFLAGS=-fuse-ld=lld \
                                                 -Wno-unused-command-line-argument
     # clang-r383902 = 11.0.1; clang-r416183b = 12.0.5; clang-r416183b1 = 12.0.7;
     # clang_13.0.0 (proton-clang 13.0.0, symlinked into prebuilts/clang/host/linux-x86/clang_13.0.0); clang-13+ is needed for Arrow-12.1 kernel sources
     TARGET_KERNEL_CLANG_VERSION := r450784d
     TARGET_KERNEL_CLANG_PATH := $(shell pwd)/prebuilts/clang/host/linux-x86/clang-r450784d
     TARGET_KERNEL_ADDITIONAL_FLAGS := DTC_EXT=$(shell pwd)/prebuilts/misc/$(HOST_OS)-x86/dtc/dtc
else
     BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
     BOARD_MKBOOTIMG_ARGS += --dtb $(DEVICE_PATH)/prebuilt/dtb.img
     TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
endif
#

#BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko exfat.ko hwid.ko goodix_core.ko msm_drm.ko qti_battery_charger_main.ko snd_event_dlkm.ko xiaomi_touch.ko"

# 12.1 manifest requirements
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true
#BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true # may not really be needed

#A/B
BOARD_USES_RECOVERY_AS_BOOT := 
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
AB_OTA_UPDATER := true

# Metadata
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm odm_dlkm product system system_ext vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # (BOARD_SUPER_PARTITION_SIZE - 4MB)

BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USES_MKE2FS := true

# System as root
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# TWRP Configuration
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_TWRPAPP := true
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 750
TW_USE_TOOLBOX := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_HAS_DOWNLOAD_MODE := true
TW_EXCLUDE_APEX := true
TW_NO_REBOOT_BOOTLOADER := true
TARGET_USES_MKE2FS := true
TW_NO_SCREEN_BLANK := true
TW_INCLUDE_CRYPTO := true
TW_BACKUP_EXCLUSIONS := /data/fonts
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"
TW_INCLUDE_PYTHON := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# unified script
PRODUCT_COPY_FILES += $(DEVICE_PATH)/prebuilt/unified-script.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/unified-script.sh
TARGET_OTA_ASSERT_DEVICE := lisa

# vendor_boot as recovery?
ifeq ($(OF_VENDOR_BOOT_RECOVERY),1)
  BOARD_BOOT_HEADER_VERSION := 4
  BOARD_USES_RECOVERY_AS_BOOT := false

  BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
  BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
  BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := false
  BOARD_USES_GENERIC_KERNEL_IMAGE := true
  BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtbs
  BOARD_INCLUDE_DTB_IN_BOOTIMG := true

  BOARD_MKBOOTIMG_ARGS += --vendor_cmdline $(VENDOR_CMDLINE)
endif
#
