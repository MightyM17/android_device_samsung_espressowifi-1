#
# Copyright (C) 2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit LineageOS specific board config
-include device/samsung/espressowifi/BoardConfigCustom.mk

# Inherit common omap4 board config
-include hardware/ti/omap4/BoardConfigCommon.mk

# Build SGX KM
-include hardware/ti/omap4/pvr-km.mk

TARGET_NO_BOOTLOADER := true

TARGET_BOOTLOADER_BOARD_NAME := piranha

# Binder API version
TARGET_USES_64_BIT_BINDER := true

# Inline kernel building
TARGET_KERNEL_SOURCE := kernel/ti/omap4
TARGET_KERNEL_CONFIG := espresso_defconfig
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_NAND_PAGE_SIZE := 4096
BOARD_NAND_SPARE_SIZE := 128
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=espresso
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

ifneq (,$(strip $(wildcard \
$(TARGET_KERNEL_SOURCE)/drivers/gpu/ion/ion_page_pool.c \
$(TARGET_KERNEL_SOURCE)/drivers/staging/android/ion/ion_page_pool.c)))
export BOARD_USE_TI_LIBION := false
endif

USE_AMAZON_DUCATI := $(if $(shell grep ^CONFIG_USE_AMAZON_DUCATI=y$$ \
$(TARGET_KERNEL_SOURCE)/arch/arm/configs/$(TARGET_KERNEL_CONFIG)),true,)

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1073741824
BOARD_CACHEIMAGE_PARTITION_SIZE := 734003200
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5003787264
BOARD_FLASH_BLOCK_SIZE := 4096

# Enable dex pre-optimization with PIC
# WITH_DEXPREOPT := true
# WITH_DEXPREOPT_PIC := true

# Configure jemalloc for low-memory
MALLOC_SVELTE := true

# Wi-Fi
BOARD_WLAN_DEVICE                := bcmdhd
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_PARAM        := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA          := "/system/etc/wifi/bcmdhd_sta.bin"
WIFI_DRIVER_FW_PATH_AP           := "/system/etc/wifi/bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/system/etc/wifi/bcmdhd_p2p.bin"
WIFI_DRIVER_MODULE_NAME          := "bcmdhd"
WIFI_BAND                        := 802_11_ABG

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/samsung/espressowifi/bluetooth

# SELinux
# BOARD_SEPOLICY_DIRS += \		     
    # device/samsung/espressowifi/sepolicy

DEVICE_MANIFEST_FILE += device/samsung/espressowifi/manifest.xml

# Recovery
RECOVERY_FSTAB_VERSION := 2
TARGET_RECOVERY_FSTAB := device/samsung/espressowifi/rootdir/fstab.espresso
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
