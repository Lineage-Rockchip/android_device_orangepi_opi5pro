#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/orangepi/opi5pro

## Bootloader
TARGET_BOOTLOADER_BOARD_NAME := rk30board

## DTB
TARGET_DTB_NAME := rk3588s-orangepi-5-pro

## Partitions
# From the stock parameter.txt; read by the common BoardConfig, so set before the include.
BOARD_SUPER_PARTITION_SIZE := 3263168512

## Stock boot.img artifacts: a single-entry dtbo.img, and the logo bitmaps resource.img is repacked around
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
TARGET_STOCK_RESOURCE_IMAGE := $(DEVICE_PATH)/prebuilt/resource.img

## Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init-files/fstab.rk30board

## Display
TARGET_SCREEN_DENSITY := 320

## Include the SoC and common tree BoardConfig makefiles
include device/rockchip/rk35xx-common/rk3588/BoardConfigSoc.mk

## Kernel config, board delta -- after the include so it is merged last
TARGET_KERNEL_CONFIG_EXT += \
    $(TARGET_KERNEL_SOURCE)/arch/arm64/configs/rk3588_opi5pro.config

## Kernel modules
# AP6256 (BCM43456) over SDIO; the Wi-Fi HAL insmods it, see wifi.load.
TARGET_KERNEL_EXT_MODULES += wifi/bcmdhd:kbuild

BOARD_VENDOR_KERNEL_MODULES_LOAD := \
    yt6801.ko \
    bcmdhd.ko

## Include the proprietary BoardConfig makefile
-include vendor/orangepi/opi5pro/BoardConfigVendor.mk
